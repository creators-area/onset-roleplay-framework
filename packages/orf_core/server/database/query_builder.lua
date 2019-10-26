local utils = ImportPackage( 'orf_utils' )
local compile = {}

QueryBuilder = {}
QueryBuilder.__index = QueryBuilder

local function backtick( input )
	if ( type( input ) == 'table' ) then
		for i = 1, #input do
			input[ i ] = ( '`%s`' ):format( input[ i ] )
		end
	elseif ( type( input ) == 'string' ) then
		input = ( '`%s`' ):format( input )
	end
	return input
end

local function parse_joins( query, builder )
	if ( #( builder._join or {} ) <= 0 ) then return query end
	for _, value in pairs( builder._join ) do
		query = query .. ' ' .. value.condition .. ' ' .. value.tbl .. ' ON ' .. value.on
	end
	return query
end

local function parse_where( query, builder )
	local copy = utils.table_copy( builder._where or {} )
	local args = {}
	if ( #copy <= 0 ) then return query end
	query = query .. ' WHERE ' .. copy[ 1 ].statement .. '?'
	table.insert( args, copy[ 1 ].value )
	table.remove( copy, 1 )
	if ( #copy <= 0 ) then return query, args end
	for _, value in ipairs( copy ) do
		query = query .. ' ' .. value.join .. ' ' .. value.statement .. '?'
		table.insert( args, value.value )
	end
	return query, args
end

function compile.SELECT( builder )
	local args = {}
	local raw_query, columns_name, tbls = 'SELECT ', table.concat( builder._select, ', ' ), table.concat( builder._from, ', ' )
	raw_query = raw_query .. columns_name
	if ( #builder._from ) > 0 then
		raw_query = raw_query .. ' FROM ' .. tbls
	end
	raw_query = parse_joins( raw_query, builder )
	raw_query, args = parse_where( raw_query, builder )
	return raw_query, args
end

function compile.INSERT( builder )
	local columns, values, args = {}, {}, {}
	for k, v in pairs( builder._values ) do
		table.insert( columns, backtick( k ) )
		table.insert( values, type( v ) == 'string' and '\'?\'' or '?' )
		table.insert( args, v )
	end
	local raw_query = ( 'INSERT INTO %s ( %s ) VALUES ( %s )'):format( table.concat( builder._from, ', ' ), table.concat( columns, ', ' ), table.concat( values, ', ' ) )
	return raw_query, args
end

function compile.UPDATE( builder )
	if ( #builder._from == 0 ) then
		print( 'No table has been specified for UPDATE call.' )
		return false
	end
	local raw_query, args, values = 'UPDATE ' .. builder._from[ 1 ] ..' SET ', {}, {}
	for k, v in pairs( builder._values ) do
		k = backtick( k )
		table.insert( values, type( v ) == 'string' and k .. ' = \'?\'' or k .. ' = ?' )
		table.insert( args, v )
	end
	raw_query = raw_query .. table.concat( values, ', ' ) 
	raw_query, where_args = parse_where( raw_query, builder )
	for i = 1, #where_args do
		table.insert( args, where_args[ i ] )
	end
	return raw_query, args
end

function compile.DELETE( builder )
	if ( #builder._from == 0 ) then
		print( 'No table has been specified for DELETE call.' )
		return false
	end
	local args = {}
	local raw_query = 'DELETE FROM ' .. table.concat( builder._from, ', ' )
	raw_query, args = parse_where( raw_query, builder )
	return raw_query, args
end

function QueryBuilder:new()
	local self = setmetatable({
		_flag = '',
		_from = '',
		_where = {},
		_join = {},
		_connection = get_connection(),
	}, QueryBuilder )
	return self
end

function QueryBuilder:select( columns )
	if ( not columns or type( columns ) ~= 'string' ) then
		print( 'Argument to select function expected' )
		return false
	end

	self._select = utils.trim( columns ) == '*' and { '*' } or backtick( utils.string_parse( columns ) )
	self._flag = 'select'
	return self
end

function QueryBuilder:from( tbl_name )
	if ( not tbl_name or type( tbl_name ) ~= 'string' ) then
		print( 'You must define a table' )
		return false
	end

	self._from = backtick( utils.string_parse( tbl_name ) )
	return self
end

function QueryBuilder:where( field, operator, value, joiner )
	if ( not field or type( field ) ~= 'string' ) then
		print( 'Matching clauses to where function expected' )
		return false
	end

	if ( not joiner ) then joiner = 'AND' end
	value = tonumber( value ) and value or utils.trim( value )
	table.insert( self._where, { join = joiner:upper(), statement = ( '`%s` %s ' ):format( utils.trim( field ), utils.trim( operator ) ), value = value } )
	return self
end

function QueryBuilder:andWhere( field, operator, value )
	return self:where( field, operator, value, 'AND' )
end

function QueryBuilder:orWhere( field, operator, value )
	return self:where( field, operator, value, 'OR' )
end

function QueryBuilder:join( tbl_name, clause, condition )
	if ( not condition ) then
		condition = 'JOIN'
	else
		condition = utils.trim( condition:upper() ) .. ' JOIN'
	end
	if ( type( clause ) == 'string' ) then
		clause = utils.trim( clause )
	end
	table.insert( self._join, { condition = condition, tbl = tbl_name, on = clause } )
	return self
end

function QueryBuilder:insert( tbl_name, values )
	self._flag = 'insert'
	self:from( tbl_name )
	self._values = self._values or {}
	for k, v in pairs( values ) do
		self._values[ k ] = v
	end
	return self
end

function QueryBuilder:delete()
	self._flag = 'delete'
	return self
end

function QueryBuilder:update( tbl_name, values )
	self._flag = 'update'
	self:from( tbl_name )
	self._values = self._values or {}
	for k, v in pairs( values ) do
		self._values[ k ] = v
	end
	return self
end


function QueryBuilder:raw( query, ... )
	self._isRaw = true
	return self:_build( query, { ... } )
end

function QueryBuilder:_build( rawSql, args )
	if ( not rawSql ) then
		rawSql, args = compile[ self._flag:upper() ]( self )
	end

	if ( args and #args > 0 ) then
		self._preparedSql = mariadb_prepare( self._connection, rawSql, table.unpack( args ) )
	else
		self._preparedSql = rawSql
	end
	return self
end

function QueryBuilder:exec( callback )
	if ( not self._isRaw ) then self:_build() end
	local prepared_sql = self._preparedSql
	if ( not prepared_sql ) then callback( false, { message = 'Cannot prepare query', status = 'error' } ) return end
	mariadb_async_query( self._connection, prepared_sql, function()
		if ( type( callback ) ~= 'function' ) then return end
		local row_count = mariadb_get_row_count()
		local row_affected = mariadb_get_affected_rows()

		-- TODO: Find a better way to handle errors
		if ( not row_count or row_count == 0 and not row_affected ) then
			callback( {}, { message = 'Query row count: 0 or something went wrong', status = 'error' } )
		end

		-- Handle results
		local results = {}
		if ( row_count and row_count > 0 ) then
			for i = 1, row_count or 0 do
				results[ #results + 1 ] = mariadb_get_assoc( i )
			end
		end

		-- Handle last inserted id
		local extras = {}
		local last_insert_id = mariadb_get_insert_id()
		if ( last_insert_id ~= nil ) then extras.last_insert_id = last_insert_id end
		if ( row_affected ~= nil ) then extras.row_affected = row_affected end
		extras.status = 'success'
		callback( results, extras )
	end)
	
	return
end
