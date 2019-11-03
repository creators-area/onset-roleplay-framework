local Account = require( 'packages/' .. GetPackageName() .. '/core/server/models/account' )
local utils = ImportPackage( 'orf_utils' )

local function GetAccountRoles( _, player_id )
	ORF.AccountManager:Get( player_id ):LoadRoles(function()
		ORF.AccountManager:Get( player_id ):GetCharacters( function()
			CallEvent( 'ORF.OnAccountLoad', player_id )
		end)
	end)
end

local function LoadOrRegisterAccount( player )
	local steam_id = tostring( GetPlayerSteamId( player ) )

	-- Check if account is allready register or not
	database.asyncQuery( database.GET_COUNT_ACCOUNT_FOR_STEAMID, { steam_id }, function( results )
		results = results[ 1 ]
		local count_results = math.tointeger( results[ 'count' ] )
		local account = ORF.AccountManager:Add( Account.new( steam_id, player ) )

		-- If player is register then load his account
		if ( count_results ~= nil and count_results >= 1 ) then
			-- Load all data from primary key
			account:Load(function()
				-- Increment login count by one
				account:IncrementLoginCount()
				-- Just update the account in db
				account:Update( GetAccountRoles )
			end)
		else
			-- Register the account for the first time
			account:Register( GetAccountRoles )
		end
	end)
end

AddEvent( 'OnPlayerSteamAuth', function( player )
	local steam_id = tostring( GetPlayerSteamId( player ) )

	database.asyncQuery( database.GET_ACCOUNT_BANS_FOR_STEAMID, { steam_id }, function( results )
		if ( type( results ) == 'table' and #results >= 1 ) then
			local reason = ( 'You\'re permanently banned for the following reason: %s' ):format( results[ 1 ].reason )
			if ( results[ 1 ].expire_ban ) then
				reason = ( 'You\'re banned until the %s for the following reason: %s' ):format( utils.format_unix_time( results[ 1 ].expire_ban ), results[ 1 ].reason )
			end
			KickPlayer( player, reason )
		end
		LoadOrRegisterAccount( player )
	end)
end)

AddEvent( 'OnPlayerJoin', function( player )
	SetPlayerSpawnLocation( player, 129532.515625, 78592.75, 1566.9007568359, 0 )
end)

AddEvent( 'ORF.OnAccountLoad', function( player )
	local account = ORF.AccountManager:Get( player )
	SetPlayerLocation( player, 129532.515625, 78592.75, 1566.9007568359 )
	SetPlayerModel( player, 5 )
	SetPlayerName( player, account:GetSteamName() )

	-- Toggle player selection UI
	--CallRemoteEvent( player, 'ORF.PlayerSelectionToggleVisiblity', account.Characters )
end)

AddEvent( 'OnPlayerQuit', function( player )
	-- Update player data before leave and then remove from the manager
	ORF.AccountManager:Get( player ):Update( function()
		ORF.AccountManager:Remove( player )
	end)
end)
