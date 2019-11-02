local admin_menu_ui = nil

local function create_web_ui()
    local w, h = GetScreenSize()
	admin_menu_ui = CreateWebUI( w * 0.15, h * 0.25, w * 0.5, h * 0.75, 10, 32 )
	SetWebAlignment( admin_menu_ui, 0, 0 )
	SetWebAnchors( admin_menu_ui, 0, 0, 0, 0 )
	LoadWebFile( admin_menu_ui, ( 'http://asset/%s/admin/client/ui/admin_menu.html' ):format( GetPackageName() ) )
	SetWebVisibility( admin_menu_ui, WEB_HIDDEN )
end

local function OnPackageStop()
    if ( admin_menu_ui ~= nil ) then
        DestroyWebUI( admin_menu_ui )
    end
end
AddEvent( 'OnPackageStop', OnPackageStop )

local function toggle_ui_visiblity( characters )
    if ( not admin_menu_ui ) then
        create_web_ui()
    end

	local is_visible = GetWebVisibility( admin_menu_ui ) == 1
	ShowMouseCursor( not is_visible )
	SetInputMode( not is_visible and INPUT_UI or INPUT_GAME )
	SetWebVisibility( admin_menu_ui, not is_visible and WEB_VISIBLE or WEB_HIDDEN )
end

AddRemoteEvent( 'ORF.OpenAdminMenu', toggle_ui_visiblity)
