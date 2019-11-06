AddEvent("OnPlayerInteractDoor", function(player, door, bWantsOpen)
	--AddPlayerChat(player, "Door: "..door..", "..tostring(bWantsOpen))

	-- Let the players open/close the door by default.
	SetDoorOpen(door, not IsDoorOpen(door))
    
    -- Play animation on open/close door
    SetPlayerAnimation(player, "KICKDOOR")
end)
