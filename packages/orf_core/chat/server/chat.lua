AddEvent( 'OnPlayerChat', function( player, message )
    AddPlayerChatAll( ( '<span color="%s"> %s (%i) : </> %s' ):format(AccountManager:Get( player ):GetColor(), GetPlayerName( player ), player, message ) )
end)

AddEvent( 'OnPlayerChatCommand', function( player, cmd, exists )
	if not exists then
		AddPlayerChat(player, 'Command /' .. cmd .. ' not found :(' )
	end

	return true
end)
