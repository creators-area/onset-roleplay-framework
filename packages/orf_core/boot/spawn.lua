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

AddEvent( 'OnPlayerJoin', function( player )
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
	SetPlayerSpawnLocation( player, -167643.890625, -39296.625, 1146.1501464844, -90 )
end)

AddEvent( 'ORF.OnAccountLoad', function( player )
	local account = ORF.AccountManager:Get( player )
	SetPlayerLocation( player, -167643.890625, -39296.625, 1146.1501464844 )
	SetPlayerName( player, account:GetSteamName() )
	Delay(1000, function()
		utils.ORF_Notify( player, 'Bienvenue parmis nous', {
			icon = 'zmdi zmdi-globe-alt zmdi-hc-md'
		})
	end)
	-- Toggle player selection UI
	-- CallRemoteEvent( player, 'ORF.PlayerSelectionToggleVisiblity', account.Characters )
end)

AddEvent( 'OnPlayerQuit', function( player )
	-- Update player data before leave and then remove from the manager
	ORF.AccountManager:Get( player ):Update( function()
		ORF.AccountManager:Remove( player )
	end)
end)

function TeleportTo(player, x, y, z, h)
	h = h or -1.0

	if (GetPlayerVehicleSeat(player) == 1) then
		local vehicle = GetPlayerVehicle(player)
		SetVehicleLocation(vehicle, x, y, z)
		if (h ~= -1.0) then
			SetVehicleHeading(vehicle, h)
		end

		-- Reset velocity
		SetVehicleLinearVelocity(vehicle, 0.0, 0.0, 0.0, true)
		SetVehicleAngularVelocity(vehicle, 0.0, 0.0, 0.0, true)
		local rx, ry, rz = GetVehicleRotation(vehicle)
		-- Reset pitch and roll, leave yaw alone
		SetVehicleRotation(vehicle, 0.0, ry, 0.0)
	else
		SetPlayerLocation(player, x, y, z)
		if (h ~= -1.0) then
			SetPlayerHeading(player, h)
		end
	end

	ResetPlayerCamera(player)
end

function cmd_getloc(player)
	local x, y, z = GetPlayerLocation(player)
	local h = GetPlayerHeading(player)

	print(x, y, z, h)
end
AddCommand("getloc", cmd_getloc)

function cmd_town(player)
	TeleportTo(player, -182821.000000, -41675.000000, 1160.000000, -90.0)
end
AddCommand("town", cmd_town)
