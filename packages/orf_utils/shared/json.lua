function json_decode( content, pos, end_delim )
	return json.parse( content, pos, end_delim )
end
AddFunctionExport( 'json_decode', json_decode )

function json_encode( content, as_key )
	return json.stringify( content, as_key )
end
AddFunctionExport( 'json_encode', json_encode )

