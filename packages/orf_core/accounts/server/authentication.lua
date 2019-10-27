local Account = require( 'packages/' .. GetPackageName() .. '/core/server/models/account' )
local utils = ImportPackage( 'orf_utils' )

AddEvent( 'OnPlayerSteamAuth', function( player )
	local steam_id = tostring( GetPlayerSteamId( player ) )

	QueryBuilder:new():raw( database.GET_ACCOUNT_BANS_FOR_STEAMID, steam_id ):exec(function( results, extras )
		if( #results >= 1 ) then
			local reason = ( 'You\'re permanently banned for the following reason: %s' ):format( results[ 1 ].reason )
			if ( results[ 1 ].expire_ban ) then
				reason = ( 'You\'re banned until the %s for the following reason: %s' ):format( utils.format_unix_time( results[ 1 ].expire_ban ), results[ 1 ].reason )
			end
			KickPlayer( player, reason )
		end
		
		LoadOrRegisterAccount( player )
	end)
end)

function LoadOrRegisterAccount( player )
	local steam_id = tostring( GetPlayerSteamId( player ) )

	-- Check if account is allready register or not
	QueryBuilder:new():raw( database.GET_COUNT_ACCOUNT_FOR_STEAMID, steam_id ):exec(function( results, extras )
		results = results[ 1 ]
		local count_results = math.tointeger( results[ 'count' ] )
		local account = AccountManager:Add( player, Account.new( steam_id ) )

		-- If player is register then load his account
		if ( count_results ~= nil and count_results >= 1 ) then
			-- Load all data from primary key
			account:Load(function( results, extras )
				-- Increment login count by one
				account:IncrementLoginCount()
				-- Just update the account in db
				account:Update( player, GetAccountRoles )
			end)
		else
			-- Register the account for the first time
			account:Register( player, GetAccountRoles )
		end
	end)
end

function GetAccountRoles( results, extras, player )
	AccountManager:Get( player ):LoadRoles(function( results, extras )
		CallEvent( 'ORF.OnAccountLoad', player )
	end)
end

AddEvent( 'OnPlayerJoin', function( player )
	SetPlayerSpawnLocation( player, 128589.000000, 78889.000000, 1576.000000, 90.0 )
end)

AddEvent( 'ORF.OnAccountLoad', function( player )
	local account = AccountManager:Get( player )
	SetPlayerLocation( player, 128589.000000, 78889.000000, 1576.000000, 90.0 )
	SetPlayerModel( player, 5 )
	SetPlayerName( player, account:GetSteamName() )

	-- Toggle player selection UI
	CallRemoteEvent( player, 'ORF.PlayerSelectionToggleVisiblity' )
end)

AddRemoteEvent( 'ORF.KickPlayer', function( player, reason )
	-- TODO: Add permission checker here
	KickPlayer( player, reason )
end)