local interfaces = {}
local i18n = ImportPackage( 'i18n' )

function makeNewInterface( package_name, web_file, size, extras )
	extras = extras or {}
	extras.order = extras.order or 10
	extras.frame_rate = extras.frame_rate or 60

	local interface_id
	if ( size == 'fullscreen' ) then
		interface_id = CreateWebUI( 0, 0, 0, 0, extras.order, extras.frame_rate )
		SetWebAlignment( interface_id, 0, 0 )
		SetWebAnchors( interface_id, 0, 0, 1, 1 )
	elseif ( type( size ) == 'table' ) then
		interface_id = CreateWebUI( size.x or 0, size.y or 0, size.w or 0, size.h or 0, extras.order, extras.frame_rate )
		SetWebAlignment( interface_id, 0, 0 )
		SetWebAnchors( interface_id, 0, 0, 0, 0 )
	end

	local t = LoadWebFile( interface_id, ( 'http://asset/%s/%s' ):format( package_name, web_file ) )

	extras.default_visibility = extras.default_visibility or WEB_HIDDEN
	SetWebVisibility( interface_id, extras.default_visibility )

	extras.show_mouse_on_show = extras.show_mouse_on_show or true
	extras.input_mode_on_show = extras.input_mode_on_show or INPUT_UI
	extras.input_mode_on_hide = extras.input_mode_on_hide or INPUT_GAME

	interfaces[ interface_id ] = {
		id = interface_id,
		package_name = package_name,
		web_file = web_file,
		size = size,
		extras = extras,
	}

	return interface_id
end
AddFunctionExport( 'makeNewInterface', makeNewInterface )

function toggleVisiblity( interface_id )
	local interface = interfaces[ interface_id ]
	if ( interface == nil ) then return end

	local is_visible = GetWebVisibility( interface_id ) == 1

	if ( interface.extras.show_mouse_on_show ) then
		ShowMouseCursor( not is_visible )
	end

	SetInputMode( not is_visible and interface.extras.input_mode_on_show or interface.extras.input_mode_on_hide )
	SetWebVisibility( interface_id, not is_visible and WEB_VISIBLE or WEB_HIDDEN )
end
AddFunctionExport( 'toggleVisiblity', toggleVisiblity )

AddEvent( 'OnWebLoadComplete', function( interface_id )
	if ( interfaces[ interface_id ] and not interfaces[ interface_id ].id_sended ) then
		SendPayloadToWebJS( interface_id, 'SaveUIIdentifier', interface_id )
		interfaces[ interface_id ].id_sended = true
	end
end)

-- Destroy all interfaces
AddEvent( 'OnPackageStop', function() for i = 1, #interfaces do DestroyWebUI( interfaces[ i ] ) end end )

-- Handle translations
AddEvent( 'ORF.GetUITranslation', function( identifier, key )
	local trans = i18n.t( interfaces[ math.tointeger( identifier ) ].package_name, key )
	SendPayloadToWebJS( identifier, 'OnReceiveTranslations', key, trans )
end)

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
	ExecuteWebJS( web_ui, ( '%s( %s );' ):format( method, table.concat( args, ', ' ) ) )
end
AddFunctionExport( 'SendPayloadToWebJS', SendPayloadToWebJS )
