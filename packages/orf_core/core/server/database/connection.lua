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

-- OnPlayerServerAuth
-- OnPlayerSteamAuth
-- OnPlayerJoin
-- OnPlayerQuit