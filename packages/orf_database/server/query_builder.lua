local utils = ImportPackage( 'orf_utils' )
local compile = {}

queryBuilder = {}

local function parse_joins( inpt, builder )
	if #( builder._join ) <= 0 then
		return inpt
	end
	for _, value in pairs( builder._join ) do
		inpt = inpt .. '\n' .. value.condition .. ' ' .. value.tbl .. '\n\tON ' .. value.on
	end
	return inpt
end

local function parse_where( query, where )
	local copy = utils.table_copy( where )
	if ( #copy == 0 ) then return query end
	query = query .. '\nWHERE ' .. copy[ 1 ].statement
	table.remove( copy, 1 )
	if ( #copy == 0 ) then return query end
	for _, value in ipairs( copy ) do
		query = query .. '\n\t' .. value.join .. ' ' .. value.statement
	end
	return query
end

function compile.SELECT( builder )
	local raw_query, colNames, tbls = 'SELECT ', table.concat( builder._select, ',\n\t' ), table.concat( builder._from, ',\n\t' )
	raw_query = raw_query .. colNames
	if #( builder._from ) > 0 then
		raw_query = raw_query .. '\nFROM ' .. tbls
	end

	raw_query = parse_joins( raw_query, builder )
	raw_query = parse_where( raw_query, builder._where )

	return raw_query
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

function queryBuilder:select( columns )
	if ( not columns ) then
		print( 'Argument to select function expected' )
		return false
	end

	if ( type( columns ) == 'string' ) then
		self._select = utils.trim( columns ) == '*' and { '*' } or utils.string_parse( columns )
	elseif ( type( columns ) == 'table' ) then
		self._select = ParseTable( columns )
	end

	self._flag = 'select'
	return self
end

function queryBuilder:from( tbl_name )
	if ( not tbl_name or type( tbl_name ) ~= 'string' ) then
		print( 'You must define a table' )
		return false
	end

	self._from = utils.string_parse( tbl_name )
	return self
end

function queryBuilder:where( field, operator, value, joiner )
	if ( not field or type( field ) ~= 'string' ) then
		print( 'Matching clauses to where function expected' )
		return false
	end

	if ( not joiner ) then joiner = 'AND' end
	value = tonumber( value ) and value or utils.trim( value )
	table.insert( self._where, { join = joiner:upper(), statement = ( '%s %s %s' ):format( utils.trim( field ), utils.trim( operator ), value ) } )
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
		condition = utils.trim( condition:upper() ) ..' JOIN'
	end
	if ( type( clause ) == 'string' ) then
		clause = utils.trim( clause )
	end
	table.insert( self._join, { condition = condition, tbl = tbl_name, on = clause } )
	return self
end

function queryBuilder:_build()
	self._rawSql = compile[ self._flag:upper() ]( self )
	return self
end

function queryBuilder:exec( callback )
	mariadb_async_query( self._connection, self:_build(), function()
		local results = {}
		for i = 1, mariadb_get_row_count() do
			results[ #results + 1 ] = mariadb_get_assoc( i )
		end

		-- Handle last inserted id
		local last_insert_id = self._isInsert and mariadb_get_insert_id() or nil
		callback( results, last_insert_id )
	end)
end