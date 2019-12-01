local utils = ImportPackage( 'orf_utils' )
local selection_ui = nil

AddEvent( 'OnPackageStart', function()
	local w, h = GetScreenSize()
	selection_ui = MakeUI( 'players/client/selection/ui/selection.html', { x = w * 0.10, y = h * 0.10, w = w * 0.20, h = h }, {
		default_visibility = WEB_HIDDEN,
		show_mouse_on_show = true,
		input_mode_on_show = INPUT_UI,
		input_mode_on_hide = INPUT_GAME
	})
end)

local function toggle_ui_visiblity( characters )
	local x, y, z = GetPlayerLocation(GetPlayerId())
	SetCameraRotation( -18, 90, 0 )
	SetCameraLocation( x, y - 200, z + 60 )

	utils.toggleVisiblity( selection_ui )

	if ( type( characters ) == 'table' ) then
		utils.SendPayloadToWebJS( selection_ui, 'loadCharacters', characters )
	end
end
AddRemoteEvent( 'ORF.PlayerSelectionToggleVisiblity', toggle_ui_visiblity )
AddEvent( 'ORF.PlayerSelectionToggleVisiblity', toggle_ui_visiblity )

-- Html call/send events
AddEvent( 'ORF.PlayerSelection:LeaveServer', function()
	CallRemoteEvent( 'ORF.KickPlayer', 'You have successfully left the server.' )
end )

AddEvent( 'ORF.PlayerSelection:CreateCharacter', function()
	utils.toggleVisiblity( selection_ui )
	CallEvent( 'ORF.PlayerCreationToggleVisiblity' )
end)
