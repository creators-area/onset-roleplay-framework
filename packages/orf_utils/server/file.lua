function file_exist( path )
	local file = io.open( path, 'r' )
	if file then
		file:close()
		return true
	end
	return false
end
AddFunctionExport( 'file_exist', file_exist )

function folder_exist( folder )
	folder = folder .. '/'
	local ok, err, code = os.rename( folder, folder )
	if ( not ok and  code == 13 ) then
		return true
	end
	return ok, err
end

function get_file_content( path )
	local file = io.open( path, 'r' )
	if ( file == nil ) then return nil end
	file:close()
	local content = ''
	for line in io.lines( path ) do
		content = content .. line
	end
	return content
end
AddFunctionExport( 'get_file_content', get_file_content )

function get_files_in_folder( directory )
	if ( not folder_exist( directory ) ) then return {} end
	local i, t, popen = 0, {}, io.popen
	for filename in popen( 'dir "' .. directory .. '" /b' ):lines() do
		i = i + 1
		t[i] = filename
	end
	return t
end
AddFunctionExport( 'get_files_in_folder', get_files_in_folder )

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
