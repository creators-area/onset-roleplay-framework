local json = require( 'packages/' .. GetPackageName() .. '/server/vendor/json' )

function json_decode( content )
	return json.decode( content )
end
AddFunctionExport( 'json_decode', json_decode )

function json_encode( content )
	return json.encode( content )
end
AddFunctionExport( 'json_encode', json_encode )

