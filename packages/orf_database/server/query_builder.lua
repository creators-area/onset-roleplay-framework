queryBuilder = { }

function queryBuilder:new( o )
	o = o or {}
	setmetatable( o, self )
	self.__index = self
	self._connection = get_connection()
	return o
end

local function build_condition()

end

function queryBuilder:from( tbl_name )
	if ( not tbl_name ) then
		error( 'You must define a table' )
		return false
	end
end

function queryBuilder:_build()

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