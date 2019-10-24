local utils = ImportPackage( 'orf_utils' )
local config = ImportPackage( 'orf_config' )

local connection

function get_connection()
	return connection
end
AddFunctionExport( 'get_connection', get_connection )

local function OnPackageStart()
	local credentials = config.get( GetPackageName(), 'database' )
	mariadb_log( credentials.log_level )
	connection = mariadb_connect( ( '%s:%s' ):format( credentials.host, credentials.port ), credentials.user, credentials.password, credentials.db_name )

	if ( connection ) then
		mariadb_set_charset( connection, credentials.charset )
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
	queryBuilder:new()
		:select( '*' )
		:from( 'accounts' )
		:where( 'id', '=', '5145646854685' )
		:exec(function( results, extra )
			utils.pprint( extra )
		end)

		queryBuilder:new():raw( 'SELECT * FROM `accounts` WHERE `id` = ?', '100010100101' ):exec(function( results, extra )
			utils.pprint( extra )
		end)
end
AddEvent( 'ORF.OnDatabaseConnected', test )
