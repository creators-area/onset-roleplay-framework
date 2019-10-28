local utils = ImportPackage( 'orf_utils' )
local BaseModel = require( 'packages/' .. GetPackageName() .. '/core/server/models/base_model' )
local Account = setmetatable( { }, { __index = BaseModel } )
Account.__index = Account

BaseModel._fields = {
	[ 'SteamId' ] 		= { type = 'string', field = 'steamid', is_primary_key = true, updatable = false },
	[ 'SteamName' ] 	= { type = 'string', field = 'steam_name' },
	[ 'GameVersion' ] 	= { type = 'int', field = 'game_version' },
	[ 'Locale' ] 		= { type = 'string', field = 'locale' },
	[ 'CountLogin' ] 	= { type = 'int', field = 'count_login' },
	[ 'CountKick' ] 	= { type = 'int', field = 'count_kick' },
	[ 'LastIp' ] 		= { type = 'string', field = 'last_ip' },
	[ 'CreatedAt' ] 	= { type = 'int', field = 'created_at', updatable = false },
	[ 'Color' ]			= { type = 'string', field = 'color', is_sync = false }
}

BaseModel._table = 'accounts'

function Account.new( primary_key )
	return setmetatable( BaseModel.new( primary_key ), Account )
end

function Account:IncrementLoginCount()
	self:SetCountLogin( math.tointeger( self:GetCountLogin() ) + 1 )
	return self
end

function Account:LoadRoles( callback, ... )
	local vargs = { ... }
	self.Roles, self.Permissions = {}, {}
	QueryBuilder:new():raw( database.GET_ACCOUNT_ROLES_AND_PERMISSIONS, self:GetPrimaryKey() ):exec(function( results, extras )
		for i = 1, #results do
			self.Roles[ results[ i ][ 'role_name' ] ] = true
			self.Permission[ results[ i ][ 'permission_name' ] ] = true
		end
		callback( results, extras, table.unpack( vargs ) )
	end)
end

function Account:AddRole( role_name )

end

function Account:RemoveRole( role_name )

end

function Account:Load( callback, ... )
	local vargs = { ... }
	QueryBuilder:new():select( '*' ):from( self._table ):where( self._PrimaryKeyField, '=', self:GetPrimaryKey() ):exec(function( results, extras )
		results = results[ 1 ]
		for k, v in pairs( self._fields ) do
			if ( results[ v.field ] ~= nil ) then
				self[ 'Set' .. k ]( self, results[ v.field ] )
			end
		end
		callback( results, extras, table.unpack( vargs ) )
	end)
end

function Account:Update( player, callback )
	self:SetGameVersion( GetPlayerGameVersion( player ) )
	self:SetSteamName( GetPlayerName( player ) )
	self:SetLocale( GetPlayerLocale( player ) )
	self:SetLastIp( GetPlayerIP( player ) )
	self:SetColor( utils.RGB2HEX( HexToRGBA( utils.RandomColor() ) ) )
	self:DbUpdate( callback, player )
end

function Account:Register( player, callback )
	self:SetSteamId( tostring( GetPlayerSteamId( player ) ) )
	self:SetGameVersion( GetPlayerGameVersion( player ) )
	self:SetSteamName( GetPlayerName( player ) )
	self:SetLocale( GetPlayerLocale( player ) )
	self:SetCountLogin( 1 )
	self:SetCountKick( 0 )
	self:SetLastIp( GetPlayerIP( player ) )
	self:SetCreatedAt( utils.get_unix_time() )
	self:SetColor( utils.RGB2HEX( HexToRGBA( utils.RandomColor() ) ) )
	self:DbSave( callback, player )
end

return Account
