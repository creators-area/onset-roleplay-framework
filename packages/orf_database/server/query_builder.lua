local utils = ImportPackage( 'orf_utils' )
local compile = {}

queryBuilder = {}

local function backtick( tbl )
	for i = 1, #tbl do
		tbl[ i ] = ( '`%s`' ):format( tbl[ i ] )
	end
	return tbl
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
	if ( #copy <= 0 ) then return query end
	for _, value in ipairs( copy ) do
		query = query .. ' ' .. value.join .. ' ' .. value.statement .. '?'
		table.insert( args, value.value )
	end
	return query, args
end

function compile.SELECT( builder )
	local args = {}
	local raw_query, colNames, tbls = 'SELECT ', table.concat( builder._select, ', ' ), table.concat( builder._from, ', ' )
	raw_query = raw_query .. colNames
	if ( #builder._from ) > 0 then
		raw_query = raw_query .. ' FROM ' .. tbls
	end
	raw_query = parse_joins( raw_query, builder )
	raw_query, args = parse_where( raw_query, builder )
	return raw_query, args
end

function queryBuilder:new( o )
	o = o or {}
	setmetatable( o, self )
	self.__index = self
	self._flag = ''
	self._from = ''
	self._where = {}
	self._join = {}
	self._connection = get_connection()
	return o
end
AddFunctionExport( 'queryBuilder', queryBuilder.new )

function queryBuilder:select( columns )
	if ( not columns or type( columns ) ~= 'string' ) then
		print( 'Argument to select function expected' )
		return false
	end

	self._select = utils.trim( columns ) == '*' and { '*' } or backtick( utils.string_parse( columns ) )
	self._flag = 'select'
	return self
end

function queryBuilder:from( tbl_name )
	if ( not tbl_name or type( tbl_name ) ~= 'string' ) then
		print( 'You must define a table' )
		return false
	end

	self._from = backtick( utils.string_parse( tbl_name ) )
	return self
end

function queryBuilder:where( field, operator, value, joiner )
	if ( not field or type( field ) ~= 'string' ) then
		print( 'Matching clauses to where function expected' )
		return false
	end

	if ( not joiner ) then joiner = 'AND' end
	value = tonumber( value ) and value or utils.trim( value )
	table.insert( self._where, { join = joiner:upper(), statement = ( '`%s` %s ' ):format( utils.trim( field ), utils.trim( operator ) ), value = value } )
	return self
end

function queryBuilder:andWhere( field, operator, value )
	return self:where( field, operator, value, 'AND' )
end

function queryBuilder:orWhere( field, operator, value )
	return self:where( field, operator, value, 'OR' )
end

function queryBuilder:join( tbl_name, clause, condition )
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

function queryBuilder:raw( query, ... )
	self:_build( query, { ... } )
	return self
end

function queryBuilder:_build( rawSql, args )
	if ( not rawSql ) then
		rawSql, args = compile[ self._flag:upper() ]( self )
	end

	if ( args and #args > 0 ) then
		self._preparedSql = mariadb_prepare( self._connection, rawSql, args and #args > 0 and table.unpack( args ) or nil )
	else
		self._preparedSql = rawSql
	end
	return self
end

function queryBuilder:exec( callback )
	self:_build()
	local prepared_sql = self._preparedSql
	if ( not prepared_sql ) then callback( false, { message = 'Cannot prepare query' } ) return end
	mariadb_query( self._connection, prepared_sql )
	local row_count = mariadb_get_row_count()

	-- TODO: Find a better way to handle errors
	if ( not row_count or row_count == 0 ) then
		callback( {}, { message = 'Query row count: 0 or something went wrong' } )
	end

	-- Handle results
	local results = mariadb_get_row_count()
	for i = 1, row_count or 0 do
		results[ #results + 1 ] = mariadb_get_assoc( i )
	end

	-- Handle last inserted id
	local extras = {}
	local last_insert_id = self._isInsert and mariadb_get_insert_id() or nil
	if ( last_insert_id ) then extras.last_insert_id = last_insert_id end

	callback( results, extras )
	return
end
