local utils = ImportPackage( 'orf_utils' )

function get( package_name, category )
	local full_file_path = string.format( 'packages/%s/config.json', package_name )
	if ( not utils.file_exist( full_file_path ) ) then
		print( ( 'Cannot find the following config file: {%s}' ):format( full_file_path ) )
		-- TODO: Find why isn't work
		ServerExit()
	end

	local stream = io.open( full_file_path )
	local content = utils.json_decode( stream:read( '*a' ) )
	stream:close()

	if ( category ~= nil and content[ category ] ~= nil ) then
		content = content[ category ]
	end

	return content or {}
end
AddFunctionExport( 'get', get )
