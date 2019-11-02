local function canOpenAdminMenu( player )
    return AccountManager:HavePermissionTo( 'open_admin_menu' )
end

AddCommand('admin', function( player )
    if ( canOpenAdminMenu( player ) ) then
        CallRemoteEvent( player, 'ORF.OpenAdminMenu' )

    else
        AddPlayerChat( player, 'You can not open this menu.' )
    end
end)
