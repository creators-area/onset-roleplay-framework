local utils = ImportPackage( 'orf_utils' )
local selection_ui = nil

local function create_web_ui()
	local w, h = GetScreenSize()
	selection_ui = CreateWebUI( w * 0.10, h * 0.10, w * 0.20, h * 1, 10, 66 )
	SetWebAlignment( selection_ui, 0, 0 )
	SetWebAnchors( selection_ui, 0, 0, 0, 0 )
	LoadWebFile( selection_ui, ( 'http://asset/%s/players/client/selection/ui/selection.html' ):format( GetPackageName() ) )
	SetWebVisibility( selection_ui, WEB_HIDDEN )
end

local function OnPackageStop()
	if ( selection_ui ~= nil ) then DestroyWebUI( selection_ui ) end
end
AddEvent( 'OnPackageStop', OnPackageStop )

local function OnKeyPress( key )

end
AddEvent( 'OnKeyPress', OnKeyPress )

local function toggle_ui_visiblity( characters )
	if ( not selection_ui ) then create_web_ui() end
	
	local x, y, z = GetPlayerLocation(GetPlayerId())
	SetCameraRotation( -18, 90, 0 )
	SetCameraLocation( x, y - 200, z + 60 )

	local is_visible = GetWebVisibility( selection_ui ) == 1
	ShowMouseCursor( not is_visible )
	SetInputMode( not is_visible and INPUT_UI or INPUT_GAME )
	SetWebVisibility( selection_ui, not is_visible and WEB_VISIBLE or WEB_HIDDEN )

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
	toggle_ui_visiblity()
	CallEvent( 'ORF.PlayerCreationToggleVisiblity' )
end)
