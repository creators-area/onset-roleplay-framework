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
	-- local vargs = { ... }
	-- QueryBuilder:new():select( '*' ):from( self._table ):where( self._PrimaryKeyField, '=', self:GetPrimaryKey() ):exec(function( results, extras )
	-- 	results = results[ 1 ]
	-- 	for k, v in pairs( self._fields ) do
	-- 		if ( results[ v.field ] ~= nil ) then
	-- 			self[ 'Set' .. k ]( self, results[ v.field ] )
	-- 		end
	-- 	end
	-- 	callback( results, extras, table.unpack( vargs ) )
	-- end)
end

function Character:Update( player, callback )
	self:DbUpdate( callback, player )
end

function Character:Register( player, callback )
	self:DbSave( callback, player )
end

return Character
