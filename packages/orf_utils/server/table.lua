function table_copy( tbl )
	local copy = {}
	for k, v in pairs( tbl ) do
		copy[ k ] = v
	end
	return copy
end
AddFunctionExport( 'table_copy', table_copy )
