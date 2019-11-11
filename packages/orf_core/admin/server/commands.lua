local utils = ImportPackage( 'orf_utils' )

AddCommand( 'admin', function( player )
    if ( not ORF.AccountManager:HavePermissionTo( player, 'open_admin_menu' ) ) then
        AddPlayerChat( player, 'You can not open this menu.' )
        return
    end
    
    CallRemoteEvent( player, 'ORF.OpenAdminMenu', GetAllPlayers() )
end)

AddCommand( 'kick', function( player, target_name, reason )
    if ( not ORF.AccountManager:HavePermissionTo( player, 'kick' ) ) then
        AddPlayerChat( player, 'You can not kick.' )
        return
    end

    reason = reason or 'no reason'

    local target = utils.GetPlayerName( target_name )

    if ( not target ) then
        AddPlayerChat( player, ( '%s not found !' ):format( target_name ) )
        return
    end

    KickPlayer( target, reason )
end)

AddRemoteEvent( 'ORF.KickPlayer', function( player, reason, target )
    if ( target ) then
        if ( ORF.AccountManager:HavePermissionTo( player, 'kick' ) ) then
            KickPlayer( target, reason )
        else
            AddPlayerChat( player, 'You can not kick.' )
        end
    else
        KickPlayer( player, reason )
    end
end)
