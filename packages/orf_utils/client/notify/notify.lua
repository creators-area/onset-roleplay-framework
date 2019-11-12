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

function ORF_Notify( title, content, extras )
	print( title, content, extras )
	SendPayloadToWebJS( notify_ui, 'onReceiveNotifyOrder', title, content, extras or {} )
end
AddEvent( 'ORF.Notify', ORF_Notify )
AddRemoteEvent( 'ORF.Notify', ORF_Notify )
AddFunctionExport( 'ORF_Notify', ORF_Notify )
