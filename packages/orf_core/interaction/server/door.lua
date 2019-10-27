AddEvent("OnPlayerInteractDoor", function(player, door, bWantsOpen)
	--AddPlayerChat(player, "Door: "..door..", "..tostring(bWantsOpen))

	-- Let the players open/close the door by default.
	if IsDoorOpen(door) then
		SetDoorOpen(door, false)
	else
		SetDoorOpen(door, true)
    end
    
    -- Play animation on open/close door
    SetPlayerAnimation(player, "KICKDOOR")
end)
