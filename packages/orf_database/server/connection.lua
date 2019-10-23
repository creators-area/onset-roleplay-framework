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
	local query = queryBuilder:new()
		:select( 'T1.steam_id, T1.cash, T2.expire_at' )
		:from( 'accounts T1' )
		:join( 'bans T2', 'T2.banned = T1.steam_id' )
		:where( 'T1.steam_id', '=', 111111111111111 )
		:orWhere( 'T1.cash', '>', 1000 )
		:andWhere( 'T1.nickname', '=', 'Kotus' ):_build()
	print( '\n' .. query._rawSql )
end
AddEvent( 'ORF.OnDatabaseConnected', test )
