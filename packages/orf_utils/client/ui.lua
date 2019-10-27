function encode_payload( mixed )
	local payload = mixed
	if ( type( mixed ) == 'string' ) then
		payload = Base64Encode( mixed )
	elseif ( type( mixed ) == 'table' ) then
		payload = Base64Encode( json_encode( payload ) )
	end
	return tostring( payload )
end
AddFunctionExport( 'encode_payload', encode_payload )

function decode_payload( payload )
	local decoded = Base64Decode( payload )
	local decoded_json = json_decode( decoded )
	if ( type( decoded_json ) == 'table' ) then
		return decoded_json
	end
	return decoded
end
AddFunctionExport( 'decode_payload', decode_payload )

function SendPayloadToWebJS( web_ui, method, ... )
	local args = { ... }
	if ( #args == 0 ) then ExecuteWebJS( web_ui, ( '%s()' ):format( method ) ) end
	for i = 1, #args do
		args[ i ] = '\'' .. encode_payload( args[ i ] ) .. '\''
	end
	ExecuteWebJS( web_ui, ( '%s( %s )' ):format( method, table.concat( args, ', ' ) ) )
end
AddFunctionExport( 'SendPayloadToWebJS', SendPayloadToWebJS )
