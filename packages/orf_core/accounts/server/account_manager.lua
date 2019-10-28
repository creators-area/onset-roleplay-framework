AccountManager = {}

local accounts = {}

function AccountManager:Add( player_id, account )
	accounts[ player_id ] = account
	return accounts[ player_id ]
end

function AccountManager:Get( player_id )
	return accounts[ player_id ] or {}
end

function AccountManager:GetAll()
	return accounts or {}
end

function AccountManager:Remove( player_id )
	accounts[ player_id ] = {}
end

function AccountManager:HaveRole( player_id, role_name )
	local account = accounts[ player_id ]
	if ( not account ) then return false end
	local roles = account.Roles
	if ( not roles or #roles == 0 ) then return false end
	return account.Roles[ role_name ]
end

function AccountManager:HavePermissionTo( player_id, permission_name )
	local account = accounts[ player_id ]
	if ( not account ) then return false end
	local permissions = account.Permissions
	if ( not permissions or #permissions == 0 ) then return false end
	return account.Permissions[ permission_name ]
end
