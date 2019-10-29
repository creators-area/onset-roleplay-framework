local utils = ImportPackage( 'orf_utils' )

database = {}

-----------------------------------------------------
-- List of usefull queries
-----------------------------------------------------

database.GET_COUNT_ACCOUNT_FOR_STEAMID = 'SELECT COUNT(steamid) as count FROM `accounts` WHERE steamid = ?'
database.GET_ACCOUNT_BANS_FOR_STEAMID = 'SELECT reason, ban_time, expire_time, ( ban_time + expire_time ) as expire_ban FROM `bans` WHERE banned = ? AND ( expire_time IS NULL OR ( expire_time IS NOT NULL AND ( ban_time + expire_time ) >= unix_timestamp() ) )'
database.GET_ACCOUNT_ROLES_AND_PERMISSIONS = 'SELECT T3.name AS `role_name`, T5.name AS `permission_name` FROM `accounts` AS T1 INNER JOIN `accounts_has_roles` AS T2 ON T2.accounts_steamid = T1.steamid AND T1.steamid = \'?\' INNER JOIN `roles` AS T3 ON T2.roles_id = T3.id INNER JOIN `roles_has_permissions` AS T4 ON T4.roles_id = T3.id INNER JOIN `permissions` AS T5 ON T4.permissions_id = T5.id'

-----------------------------------------------------
-- Function used to get the current connection to the database
-- Also available on other packages
-----------------------------------------------------

function database.GetConnection()
	return database._con
end
AddFunctionExport( 'get_connection', database.GetConnection )

-----------------------------------------------------
-- Functions used to handle query
-----------------------------------------------------

local function prepareQuery( raw_query, parameters )
	local prepared_query = raw_query
	if ( type( parameters ) == 'table' and #parameters > 0 ) then
		prepared_query = mariadb_prepare( database.GetConnection(), raw_query, table.unpack( parameters ) )
	end
	return prepared_query
end

local function getResults()
	local results = {}
	results.row_count = mariadb_get_row_count()
	results.affected_rows = mariadb_get_affected_rows()
	results.last_insert_id = mariadb_get_insert_id()

	if ( results.row_count ~= nil and tonumber( results.row_count ) ~= nil and tonumber( results.row_count ) > 0 ) then
		for i = 1, tonumber( results.row_count ) or 0 do
			results[ #results + 1 ] = mariadb_get_assoc( i )
		end
	end
	return results
end

function database.query( raw_query, parameters )
	local prepared_query = prepareQuery( raw_query, parameters )
	if ( not prepared_query ) then
		utils.error( ( 'Cannot prepare the following query: %s' ):format( raw_query ) )
		return false
	end

	mariadb_await_query( database.GetConnection(), prepared_query )
	local results = getResults()
	return results
end

function database.asyncQuery( raw_query, parameters, callback )
	local prepared_query = prepareQuery( raw_query, parameters )
	if ( not prepared_query ) then
		utils.error( ( 'Cannot prepare the following query: %s' ):format( raw_query ) )
		return false
	end

	mariadb_async_query( database.GetConnection(), prepared_query, function()
		if ( type( callback ) == 'function' ) then callback( getResults() ) end
	end)
end


-- TODO: Refactor this shit
local function insert_roles_and_permissions()
	local permissions = utils.get_config( GetPackageName(), 'permissions' )
	for i = 1, #permissions do
		local permission = permissions[ i ]
		database.asyncQuery( 'INSERT IGNORE INTO `permissions` VALUES ( ?, \'?\', \'?\' )', { permission.id, permission.name, permission.description } )
	end

	local roles = utils.get_config( GetPackageName(), 'roles' )
	for i = 1, #roles do
		local role = roles[ i ]
		database.asyncQuery( 'INSERT IGNORE INTO `roles` VALUES ( ?, \'?\', \'?\', ? )', { role.id, role.name, role.description, role.is_default }, function( _ )
			for j = 1, #role.permissions do
				local permission = role.permissions[ j ]
				database.asyncQuery( 'INSERT IGNORE INTO `roles_has_permissions` VALUES ( ?, ? )', { role.id, permission } )
			end
		end)
	end
end

-----------------------------------------------------
-- Function used to intanciate the database connection and the default content
-----------------------------------------------------

-- Init database connexion on package start
AddEvent( 'OnPackageStart', function()
	local credentials = utils.get_config( GetPackageName(), 'database' )
	database._logLevel = credentials.log_level
	mariadb_log( database._logLevel )
	database._con = mariadb_connect( ( '%s:%s' ):format( credentials.host, credentials.port ), credentials.user, credentials.password, credentials.db_name )
	AddEvent( 'OnPackageStop', function() mariadb_close( database.GetConnection() ) end )
	CallEvent( 'ORF.OnDatabaseConnected' )

	if ( database.GetConnection() ) then
		mariadb_set_charset( database.GetConnection(), credentials.charset )
		CallEvent( 'ORF.OnDatabaseCreated' )
	else
		utils.error( 'Cannot connect to server, please check your credentials in config.json' )
		ServerExit()
	end

	CallEvent( 'ORF.OnDatabaseInit' )
end)

-- Used to create the defaults database scheme
AddEvent( 'ORF.OnDatabaseCreated', function()
	local script_path = utils.get_config( GetPackageName(), 'database' ).script_path
	if ( utils.file_exist( script_path ) ) then
		mariadb_await_query_file( database.GetConnection(), script_path )
	end
	insert_roles_and_permissions()
end)
