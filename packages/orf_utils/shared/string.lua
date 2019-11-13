function start_with( str, find )
	return str:find( '^' .. find ) ~= nil
end
AddFunctionExport( 'start_with', start_with )
