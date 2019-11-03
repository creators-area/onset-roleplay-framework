ORF = ORF or {}
ORF.AccountManager = {}

local accounts = {}

function ORF.AccountManager:Add( account )
	accounts[ account._playerId ] = account
	return accounts[ account._playerId ]
end

function ORF.AccountManager:Get( player_id )
	return accounts[ player_id ] or {}
end

function ORF.AccountManager:GetAll()
	return accounts or {}
end

function ORF.AccountManager:Remove( player_id )
	accounts[ player_id ] = nil
end

function ORF.AccountManager:GetCurrentCharacter( player_id )
	local account = accounts[ player_id ]
	if ( not account or account._currentCharacterId == nil or account.Characters == nil or #account.Characters == 0 ) then return nil end
	return account.Characters[ account._currentCharacterId ]
end

function ORF.AccountManager:HaveRole( player_id, role_name )
	local account = accounts[ player_id ]
	if ( not account ) then return false end
	local roles = account.Roles
	if ( not roles or #roles == 0 ) then return false end
	return account.Roles[ role_name ]
end

function ORF.AccountManager:HavePermissionTo( player_id, permission_name )
	local account = accounts[ player_id ]
	if ( not account ) then return false end
	local permissions = account.Permissions
	if ( type( permissions ) ~= 'table' ) then return false end
	return account.Permissions[ permission_name ]
end
