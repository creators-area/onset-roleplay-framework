local debug = ImportPackage( 'orf_debug' )

local function load( package_name, file_path, category )
	local full_file_path = string.format( 'packages/%s/%s', package_name, file_path )
	if ( not debug.file_exist( full_file_path ) ) then
		ServerExit( string.format( 'Cannot find the following config file: {%s}', full_file_path ) )
	end

	local file_stream = ini_open( full_file_path )
	-- TODO: Handle file content
	ini_close( file_stream )

	return {}
end
AddFunctionExport( 'load', load )
