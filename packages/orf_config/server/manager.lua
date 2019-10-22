local debug = ImportPackage( 'orf_debug' )
local json = require( 'json' )

local function load( package_name, category )
	local full_file_path = string.format( 'packages/%s/config.json', package_name )
	if ( not debug.file_exist( full_file_path ) ) then
		ServerExit( string.format( 'Cannot find the following config file: {%s}', full_file_path ) )
	end

	local stream = io.open( full_file_path )
	local content = json.decode( io.read( '*a' ) )
	stream:close()

	if ( category ~= nil and content[ category ] ~= nil ) then
		content = content[ category ]
	end

	return content or {}
end
AddFunctionExport( 'load', load )
