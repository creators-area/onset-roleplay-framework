local Account = require( 'packages/' .. GetPackageName() .. '/server/models/account' )
local utils = ImportPackage( 'orf_utils' )

AddEvent( 'OnPlayerSteamAuth', function( player )
	local steam_id = tostring( GetPlayerSteamId( player ) )

	-- Check if account is allready register or not
	QueryBuilder:new():raw( 'SELECT COUNT(steamid) as count FROM `accounts` WHERE steamid = ?', steam_id ):exec(function( results, extras )
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
				account:Update( player, check_account_bans )
			end)
		else
			-- Register the account for the first time
			account:Register( player, check_account_bans )
		end
	end)
end)

function check_account_bans( results, extras, player )
	print( 'check_account_bans', AccountManager:Get( player ):GetSteamName() )
	-- TODO: Handle query to check if account is banned
	check_account_roles( player )
end

function check_account_roles( player )
	print( 'check_account_roles', AccountManager:Get( player ):GetSteamName() )
	-- TODO: Handle query to sync account's roles
	CallEvent( 'ORF.OnAccountLoad', player )
end

AddEvent( 'ORF.OnAccountLoad', function( player )
	local account = AccountManager:Get( player )
	SetPlayerLocation( player, 125773.000000, 80246.000000, 1700.000000 )
	if ( h ~= -1.0 ) then
		SetPlayerHeading( player, 90.0 )
	end
	SetPlayerModel( player, 0 )
	SetPlayerName( player, account:GetSteamName() )

	-- Toggle player selection UI
	CallRemoteEvent( player, 'ORF.PlayerSelectionToggleVisiblity' )
end)