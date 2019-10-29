local BaseModel = require( 'packages/' .. GetPackageName() .. '/core/server/models/base_model' )
local Character = setmetatable( { }, { __index = BaseModel } )
Character.__index = Character

BaseModel._fields = {
	[ 'Id' ] 		= { type = 'int', field = 'id', is_primary_key = true, updatable = false },
}

BaseModel._table = 'players'

function Character.new( primary_key )
	return setmetatable( BaseModel.new( primary_key ), Character )
end

function Character:Load( callback, ... )
	local vargs = { ... }
	local query ( 'SELECT * FROM `%s` WHERE %s = ? LIMIT 1' ):format( self._table, self._PrimaryKeyField )
	database.asyncQuery( query, { self:GetPrimaryKey() }, function( results )
		results = results[ 1 ]
		for k, v in pairs( self._fields ) do
			if ( results[ v.field ] ~= nil ) then
				self[ 'Set' .. k ]( self, results[ v.field ] )
			end
		end
		callback( results, table.unpack( vargs ) )
	end)
end

function Character:Update( player, callback )
	self:DbUpdate( callback, player )
end

function Character:Register( player, callback )
	self:DbSave( callback, player )
end

return Character
