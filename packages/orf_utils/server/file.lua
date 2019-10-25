function file_exist( path )
	local file = io.open( path, 'r' )
	if file then
		file:close()
		return true
	end
	return false
end
AddFunctionExport( 'file_exist', file_exist )

function get_config( package_name, category )
	local full_file_path = string.format( 'packages/%s/config.json', package_name )
	if ( not file_exist( full_file_path ) ) then
		ServerExit()
		error( ( 'Cannot find the following config file: {%s}' ):format( full_file_path ) )
	end

	local stream = io.open( full_file_path )
	local content = json_decode( stream:read( '*a' ) )
	stream:close()

	if ( category ~= nil and content[ category ] ~= nil ) then
		content = content[ category ]
	end

	return content or {}
end
AddFunctionExport( 'get_config', get_config )