local notify_ui = nil

AddEvent( 'OnPackageStart', function()
	notify_ui = CreateWebUI( 0, 0, 0, 0, 99, 66 )
	SetWebAlignment( notify_ui, 0, 0 )
	SetWebAnchors( notify_ui, 0, 0, 1, 1 )
	LoadWebFile( notify_ui, ( 'http://asset/%s/client/notify/notify.html' ):format( GetPackageName() ) )
	SetWebVisibility( notify_ui, WEB_VISIBLE )
end)

AddEvent( 'OnPackageStop', function()
	if ( notify_ui ~= nil ) then DestroyWebUI( notify_ui ) end
end)

function Notify( title, content, extras )
	SendPayloadToWebJS( notify_ui, 'onReceiveNotifyOrder', title, content, extras )
end
AddEvent( 'ORF.Notify', Notify )
AddRemoveEvent( 'ORF.Notify', Notify )
AddFunctionExport( 'ORF_Notify', Notify )
