function ORF_Notify( player, title, content, extras )
    CallRemoteEvent( player, 'ORF.Notify', title, content, extras )
end
AddFunctionExport( 'ORF_Notify', ORF_Notify )