local function file_exist( path )
	local file = io.open( path, 'r' )
	if file then
		file:close()
		return true
	end
	return false
end
AddFunctionExport( 'file_exist', file_exist )
