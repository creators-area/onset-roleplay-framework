local utils = ImportPackage('orf_utils')
local BaseModel = require( 'packages/' .. GetPackageName() .. '/core/server/models/base_model' )
local Character = setmetatable( { }, { __index = BaseModel } )
Character.__index = Character

BaseModel._fields = {
	[ 'Id' ] 		= 	{ type = 'int', field = 'id', is_primary_key = true, updatable = false },
	[ 'FirstName' ] = 		{ type = 'string', field = 'firstname' },
	[ 'LastName' ] = 	{ type = 'string', field = 'lastname' },
	[ 'Account' ] = 	{ type = 'int', field = 'account_id', updatable = false },
	[ 'Health' ] = 		{ type = 'int', field = 'health' },
	[ 'Armor' ] = 		{ type = 'int', field = 'armor' },
	[ 'Cash' ] = 		{ type = 'int', field = 'cash' },
	[ 'BankCash' ] = 	{ type = 'int', field = 'bank_cash' },
	[ 'Clothes' ] = 	{ type = 'array', field = 'clothes' },
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
				self[ 'Set' .. k ]( self, v.type == 'array' and utils.json_decode( results[ v.field ] ) or results[ v.field ] )
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
