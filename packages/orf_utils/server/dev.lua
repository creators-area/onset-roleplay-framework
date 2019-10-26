function TeleportTo(player, x, y, z, h)
	h = h or -1.0

	if (GetPlayerVehicleSeat(player) == 1) then
		local vehicle = GetPlayerVehicle(player)
		SetVehicleLocation(vehicle, x, y, z)
		if (h ~= -1.0) then
			SetVehicleHeading(vehicle, h)
		end

		-- Reset velocity
		SetVehicleLinearVelocity(vehicle, 0.0, 0.0, 0.0, true)
		SetVehicleAngularVelocity(vehicle, 0.0, 0.0, 0.0, true)
		local rx, ry, rz = GetVehicleRotation(vehicle)
		-- Reset pitch and roll, leave yaw alone
		SetVehicleRotation(vehicle, 0.0, ry, 0.0)
	else
		SetPlayerLocation(player, x, y, z)
		if (h ~= -1.0) then
			SetPlayerHeading(player, h)
		end
	end

	ResetPlayerCamera(player)
end

function cmd_beach(player)
	TeleportTo(player, 208591.0, 212335.0, 455.0, 180.0)
end
AddCommand("beach", cmd_beach)

function cmd_police(player)
	TeleportTo(player, 173479.0, 192671.0, 1335.0, -90.0)
end
AddCommand("police", cmd_police)

function cmd_gas(player)
	TeleportTo(player, 125773.000000, 80246.000000, 1645.000000, 90.0)
end
AddCommand("gas", cmd_gas)

function cmd_getpos(player)
	local x, y, z = GetPlayerLocation( player )
	AddPlayerChat( player, table.concat( { x, y, z }, ', ' ) )
end
AddCommand("getpos", cmd_getpos)