local utils = ImportPackage( 'orf_utils' )
local admin_menu_ui = nil

local function CreateAdminMenu()
    local w, h = GetScreenSize()
	admin_menu_ui = CreateWebUI( w * 0.35, h * 0.25, w * 0.75, h * 0.75, 10, 32 )

	LoadWebFile( admin_menu_ui, ( 'http://asset/%s/admin/client/ui/admin_menu.html' ):format( GetPackageName() ) )
	SetWebSize( admin_menu_ui, w * 0.75, h )
	SetWebAlignment( admin_menu_ui, 0, 0 )
	SetWebAnchors( admin_menu_ui, 0, 0, 0, 0 )
	SetWebVisibility( admin_menu_ui, WEB_HIDDEN )
end

local function ToggleAdminMenu( players )
    if ( not admin_menu_ui ) then
        CreateAdminMenu()
	end

	if ( type( players ) == 'table' ) then
        utils.SendPayloadToWebJS( admin_menu_ui, 'loadPlayers', players )
    end

	local is_visible = GetWebVisibility( admin_menu_ui ) == 1
	
	ShowMouseCursor( not is_visible )
	SetInputMode( not is_visible and INPUT_GAMEANDUI or INPUT_GAME )
	SetWebVisibility( admin_menu_ui, not is_visible and WEB_VISIBLE or WEB_HIDDEN )
end

AddEvent( 'OnPackageStop', function()
	if ( admin_menu_ui ~= nil ) then
        DestroyWebUI( admin_menu_ui )
    end
end)

AddEvent( 'OnKeyPress', function( key )	
	if ( key == "F5" ) then
		ToggleAdminMenu()
	end
end)

AddRemoteEvent( 'ORF.OpenAdminMenu', ToggleAdminMenu)
