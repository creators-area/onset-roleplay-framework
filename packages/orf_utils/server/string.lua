function trim( str )
	if type( str ) ~= 'string' then return end
	local x = str:match "^%s*(.-)%s*$"
	return x
end
AddFunctionExport( 'trim', trim )

function string_parse( str )
	local parsed = {}
	for match in str:gmatch( '[^,]+' ) do
		table.insert( parsed, trim( match ) )
	end
	return parsed
end
AddFunctionExport( 'string_parse', string_parse )
