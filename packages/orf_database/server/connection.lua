local utils = ImportPackage( 'orf_utils' )

local connection

function get_connection()
	return connection
end
AddFunctionExport( 'get_connection', get_connection )

local function OnPackageStart()
	local credentials = utils.get_config( GetPackageName(), 'database' )
	mariadb_log( credentials.log_level )
	connection = mariadb_connect( ( '%s:%s' ):format( credentials.host, credentials.port ), credentials.user, credentials.password, credentials.db_name )

	if ( connection ) then
		mariadb_set_charset( connection, credentials.charset )
		-- TODO: Handle use db and remove database name from sql file
		if ( utils.file_exist( credentials.script_path ) ) then
			mariadb_await_query_file( connection, credentials.script_path )
		end
	else
		ServerExit()
		error( 'Cannot connect to server, please check your credentials in config.json' )
	end

	CallEvent( 'ORF.OnDatabaseConnected' )
end
AddEvent( 'OnPackageStart', OnPackageStart )

local function OnPackageStop()
	mariadb_close( connection )
end
AddEvent( 'OnPackageStop', OnPackageStop )

local function test()
	queryBuilder:new():delete():from( 'accounts' ):where( 'steamid', '=', '76561198181970707' ):exec(function( results, extras )
		queryBuilder:new():insert( 'accounts', {
			[ 'steamid' ] = '76561198181970707',
			[ 'steam_name' ] = 'Kotus',
			[ 'game_version' ] = 162,
			[ 'locale' ] = 'fr_FR',
			[ 'count_login' ] = '0',
			[ 'count_kick' ] = '0',
			[ 'last_ip' ] = '127.0.0.1',
			[ 'created_at' ] = utils.get_unix_time()
		}):exec(function( results, extras )
			queryBuilder:new():raw( 'SELECT * FROM `accounts`' ):exec(function( results, extra )
				queryBuilder:new():update( 'accounts', { [ 'steam_name' ] = 'Koazdazdtussss' } ):where( 'steamid', '=', '76561198181970707' ):exec()
			end)
		end)
	end)
end
AddEvent( 'ORF.OnDatabaseConnected', test )


-- OnPlayerServerAuth
-- OnPlayerSteamAuth
-- OnPlayerJoin
-- OnPlayerQuit