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

end

function AccountManager:HavePermissionTo( player_id, permission_name )

end

AddRemoteEvent( 'ORF.KickPlayer', function( player, reason )
	-- TODO: Add permission checker here
	KickPlayer( player, reason )
end)