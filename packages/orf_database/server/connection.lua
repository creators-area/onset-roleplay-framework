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
	else
		-- TODO: Handle error message
		ServerExit()
	end

	CallEvent( 'ORF.OnDatabaseConnected' )
end
AddEvent( 'OnPackageStart', OnPackageStart )

local function OnPackageStop()
	mariadb_close( connection )
end
AddEvent( 'OnPackageStop', OnPackageStop )

local function test()
	local query = queryBuilder:new()



	-- utils.orf_print( query._connection )
end
AddEvent( 'ORF.OnDatabaseConnected', test )
