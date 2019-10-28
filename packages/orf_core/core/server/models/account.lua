local utils = ImportPackage( 'orf_utils' )
local BaseModel = require( 'packages/' .. GetPackageName() .. '/core/server/models/base_model' )
local Character = require( 'packages/' .. GetPackageName() .. '/core/server/models/character' )
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

function Account:GetCharacters( callback, ... )
	local vargs = { ... }
	self.Characters = {}
	QueryBuilder:new():select( 'id' ):from( 'players' ):where( 'account_id', '=', self:GetPrimaryKey() ):exec(function( results, extras )
		for i = 1, #results do
			local result = results[ i ]
			self.Characters[ result.id ] = Character.new( result.id )
		end
		callback( results, extras, table.unpack( vargs ) )
	end)
end

function Account:SetCurrentCharacter( id )
	local character = self.Characters[ id ]
	if ( not character ) then return false end
	self._currentCharacterId = id
	CallEvent( 'ORF.OnPlayerChangeCurrentCharacter', self._playerId, self._currentCharacterId )
	return true
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
	-- TODO: Implemment AddRole
end

function Account:RemoveRole( role_name )
	-- TODO: Implemment RemoveRole
end

return Account
