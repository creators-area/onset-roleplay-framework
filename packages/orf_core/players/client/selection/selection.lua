local utils = ImportPackage( 'orf_utils' )
local selection_ui = nil

function create_web_ui()
	selection_ui = CreateWebUI( 0, 0, 0, 0, 10, 16 )
	SetWebAlignment( selection_ui, 0, 0 )
	SetWebAnchors( selection_ui, 0, 0, 1, 1 )
	LoadWebFile( selection_ui, ( 'http://asset/%s/players/client/selection/ui/selection.html' ):format( GetPackageName() ) )
	SetWebVisibility( selection_ui, WEB_HIDDEN )
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

-- Html call/send events

function LeaveServer()
	CallRemoteEvent( 'ORF.KickPlayer', 'You have successfully left the server.' )
end
AddEvent( 'ORF.PlayerSelection:LeaveServer', LeaveServer )

function SendCharactersInformation()
	utils.SendPayloadToWebJS( selection_ui, 'onReceiveData', { test = 'player 1' }, 'test' )
end
AddEvent( 'ORF.Test', SendCharactersInformation )

AddEvent( 'ORF.OnAccountLoad', function( player )

end)