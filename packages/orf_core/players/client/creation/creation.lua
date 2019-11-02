local utils = ImportPackage( 'orf_utils' )
local creation_ui = nil

local function create_web_ui()
    local w, h = GetScreenSize()
	creation_ui = CreateWebUI( w * 0.15, h * 0.25, w * 0.5, h * 0.75, 10, 32 )
	SetWebAlignment( creation_ui, 0, 0 )
	SetWebAnchors( creation_ui, 0, 0, 0, 0 )
	LoadWebFile( creation_ui, ( 'http://asset/%s/players/client/creation/ui/creation.html' ):format( GetPackageName() ) )
	SetWebVisibility( creation_ui, WEB_HIDDEN )
end

local function OnPackageStop()
	if ( creation_ui ~= nil ) then DestroyWebUI( creation_ui ) end
end
AddEvent( 'OnPackageStop', OnPackageStop )

local function OnKeyPress( key )

end
AddEvent( 'OnKeyPress', OnKeyPress )

local function toggle_ui_visiblity( characters )
    if ( not creation_ui ) then create_web_ui() end
    
	SetCameraRotation( 0, 180, 0 )
	SetCameraLocation( 129879.734375, 78750, 1656.2053222656 )

	local is_visible = GetWebVisibility( creation_ui ) == 1
	ShowMouseCursor( not is_visible )
	SetInputMode( not is_visible and INPUT_UI or INPUT_GAME )
	SetWebVisibility( creation_ui, not is_visible and WEB_VISIBLE or WEB_HIDDEN )

end
AddRemoteEvent( 'ORF.PlayerCreationToggleVisiblity', toggle_ui_visiblity )
AddEvent( 'ORF.PlayerCreationToggleVisiblity', toggle_ui_visiblity )

-- Html call/send events
