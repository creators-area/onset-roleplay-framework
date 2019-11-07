function GetPlayerByName( player_name )
	for k,v in pairs( GetAllPlayers() ) do
        if ( GetPlayerName( v ):lower() == ( player_name ):lower() ) then
            return v
        end
    end

	return false
end
AddFunctionExport( 'GetPlayerByName', GetPlayerByName )
