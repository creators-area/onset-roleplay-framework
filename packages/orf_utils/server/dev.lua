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

function cmd_gas(player)
	TeleportTo(player, 125773.000000, 80246.000000, 1645.000000, 90.0)
end
AddCommand("gas", cmd_gas)

function cmd_getpos(player)
	local x, y, z = GetPlayerLocation( player )
	AddPlayerChat( player, table.concat( { x, y, z }, ', ' ) )
	print( table.concat( { x, y, z }, ', ' ) )
end
AddCommand("getpos", cmd_getpos)


function info(player)
	print( 'GetPlayerLocation()' )
	local x, y, z = GetPlayerLocation(player)
	print( x, y, z )
	CallRemoteEvent( player, 'DEV.GetInfo' )
end
AddCommand('info', info)

function cmd_getloc(player)
	local x, y, z = GetPlayerLocation(player)
	local h = GetPlayerHeading(player)

	print(x, y, z, h)
end
AddCommand("getloc", cmd_getloc)

function cmd_town(player)
	TeleportTo(player, -182821.000000, -41675.000000, 1160.000000, -90.0)
end
AddCommand("town", cmd_town)
