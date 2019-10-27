local utils = ImportPackage( 'orf_utils' )

local connection

function get_connection()
	return connection
end
AddFunctionExport( 'get_connection', get_connection )

local function insert_roles_and_permissions()
	local permissions = utils.get_config( GetPackageName(), 'permissions' )
	for i = 1, #permissions do
		local permission = permissions[ i ]
		QueryBuilder:new():raw( 'INSERT IGNORE INTO `permissions` ( `name`, `description` ) VALUES ( \'?\', \'?\' )', permission.name, permission.description ):exec()
	end

	local roles = utils.get_config( GetPackageName(), 'roles' ).roles
	for i = 1, #roles do
		local role = roles[ i ]
		QueryBuilder:new():raw( 'INSERT IGNORE INTO `roles` ( `name`, `description` ) VALUES ( \'?\', \'?\' )', role.name, role.description ):exec()
	end
end

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
		insert_roles_and_permissions()
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
