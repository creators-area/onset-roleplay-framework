local selection_ui = nil

AddEvent( 'OnPackageStart', function()
	local width, height = GetScreenSize()
	selection_ui = CreateWebUI( 0, 0, width, height )
	SetWebAlignment( selection_ui, 0, 0 )
	SetWebAnchors( selection_ui, 0, 0, 0, 0 )
	LoadWebFile( selection_ui, ( 'http://asset/%s/client/players/ui/selection.html' ):format( GetPackageName() ) )
	SetWebVisibility( selection_ui, WEB_HIDDEN )
end)

AddEvent( 'OnPackageStop', function()
	DestroyWebUI( selection_ui )
end)

AddEvent( 'OnKeyPress', function( key )

end)

function toggle_ui_visiblity()
	print( 'Toggle selection UI' )
	local is_visible = GetWebVisibility( selection_ui )
	ShowMouseCursor( not is_visible )
	SetInputMode( is_visible and INPUT_GAME or INPUT_UI )
	SetWebVisibility( selection_ui, is_visible and WEB_HIDDEN or WEB_VISIBLE )
end
AddRemoteEvent( 'ORF.PlayerSelectionToggleVisiblity', toggle_ui_visiblity )















AddEvent( 'ORF.OnAccountLoad', function( player )

end)