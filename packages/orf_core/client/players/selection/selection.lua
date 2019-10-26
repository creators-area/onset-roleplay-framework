local selection_ui = nil

function create_web_ui()
	local width, height = GetScreenSize()
	selection_ui = CreateWebUI( 0, 0, width, height, 1, 32 )
	SetWebAlignment( selection_ui, 0, 0 )
	SetWebAnchors( selection_ui, 0, 0, 0, 0 )
	LoadWebFile( selection_ui, ( 'http://asset/%s/client/players/selection/ui/selection.html' ):format( GetPackageName() ) )
	SetWebVisibility( selection_ui, WEB_HIDDEN )
	AddPlayerChat( ( 'width:%s heigth:%s' ):format( width, height ) )
end

function OnPackageStop()
	DestroyWebUI( selection_ui )
end
AddEvent( 'OnPackageStop', OnPackageStop )

function OnKeyPress( key )

end
AddEvent( 'OnKeyPress', OnKeyPress )

function toggle_ui_visiblity()
	if ( not selection_ui ) then create_web_ui() end
	AddPlayerChat( 'Selection:toggle_ui_visiblity' )
	local is_visible = GetWebVisibility( selection_ui ) == 1
	ShowMouseCursor( not is_visible )
	SetInputMode( not is_visible and INPUT_UI or INPUT_GAME )
	SetWebVisibility( selection_ui, not is_visible and WEB_VISIBLE or WEB_HIDDEN )
end
AddRemoteEvent( 'ORF.PlayerSelectionToggleVisiblity', toggle_ui_visiblity )















AddEvent( 'ORF.OnAccountLoad', function( player )

end)