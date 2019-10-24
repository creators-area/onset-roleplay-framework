--[[

This script contains all interactive doors/gates in the game.

]]--

AddEvent("OnPlayerInteractDoor", function(player, door, bWantsOpen)
	--AddPlayerChat(player, "Door: "..door..", "..tostring(bWantsOpen))

	-- Let the players open/close the door by default.
	if IsDoorOpen(door) then
		SetDoorOpen(door, false)
	else
		SetDoorOpen(door, true)
	end
end)

AddEvent("OnPackageStart", function()
	
	-- Town level mobile houses
	CreateDoor(40, -161386.000000, -39784.500000, 1085.000000, 0.0, true)
	CreateDoor(40, -162288.000000, -36656.000000, 1085.000000, 0.0, true)
	CreateDoor(40, -158468.000000, -39638.199219, 1085.000000, 0.0, true)
	CreateDoor(40, -158320.000000, -36831.199219, 1085.000000, -90.0, true)
	CreateDoor(40, -155095.000000, -38000.199219, 1085.000000, -90.0, true)
	CreateDoor(40, -155325.000000, -35741.000000, 1085.000000, -180.0, true)
	
	CreateDoor(41, -174589.000000, -38487.000000, 1025.000000, -90.0, true)
	CreateDoor(41, -172828.000000, -41752.000000, 1025.000000, 0.0, true)
	CreateDoor(41, -177836.000000, -38578.000000, 1025.000000, 90.0, true)
	CreateDoor(41, -174588.000000, -45277.000000, 1025.000000, -90.0, true)
	CreateDoor(41, -172818.000000, -33414.000000, 1025.000000, 0.0, true)
	
	CreateDoor(31, -168700.000000, -38920.000000, 1051.000000, 0.0, true) -- Front sliding door gas station town
	CreateDoor(3, -169403.000000, -39609.000000, 1051.000000, -90.0, true) -- Back door gas station town
	
	-- House doors
	CreateDoor(20, -171043.000000, -33401.000000, 1131.000000, 90.0, true)
	CreateDoor(23, -171090.000000, -33189.000000, 1130.000000, 0.0, true)
	CreateDoor(20, -169720.000000, -45762.000000, 1141.000000, 270.0, true)
	CreateDoor(22, -170169.000000, -46594.000000, 1141.000000, 90.0, true)
	CreateDoor(24, -169674.000000, -45973.000000, 1142.000000, 180.0, true)
	CreateDoor(20, -174799.000000, -36578.000000, 1129.000000, 0.0, true)
	CreateDoor(23, -174097.000000, -37446.000000, 1129.000000, 0.0, true)
	CreateDoor(23, -174380.000000, -36595.000000, 1468.000000, 0.0, true)
	CreateDoor(23, -174139.000000, -37072.000000, 1467.000000, 90.0, true)
	CreateDoor(20, -177823.000000, -37014.000000, 1139.000000, 180.0, true)
	CreateDoor(23, -178293.000000, -36769.000000, 1139.000000, 90.0, true)
	CreateDoor(20, -177842.000000, -41749.000000, 1137.000000, 180.0, true)
	CreateDoor(23, -178502.000000, -41690.000000, 1137.000000, 90.0, true)
	CreateDoor(21, -174179.000000, -41970.000000, 1129.000000, 90.0, true)
	CreateDoor(20, -174585.000000, -46782.000000, 1150.000000, 0.0, true)
	CreateDoor(20, -177721.000000, -45803.000000, 1140.000000, -90.0, true)
	CreateDoor(23, -177673.000000, -46192.000000, 1140.000000, 180.0, true)
	CreateDoor(21, -177532.000000, -49729.000000, 1145.000000, 180.0, true)
	CreateDoor(23, -178660.000000, -49881.000000, 1146.000000, 0.0, true)
	CreateDoor(22, -179061.000000, -49841.000000, 1146.000000, 0.0, true)
	
	
	CreateDoor(35, -182093.000000, -40643.000000, 1065.000000, 90.0, true) -- Armed&Dangerous front
	CreateDoor(36, -180794.000000, -40995.000000, 1065.000000, 0.0, true) -- A&D back door

	CreateDoor(17, 128469.000000, 78057.000000, 1474.000000, 90.0, true) -- Desert Gas Station Entrance Physics Door
	CreateDoor(25, 128690.000000, 78965.000000, 1480.000000, 90.0, true) -- Desert Gas Station Restroom
	CreateDoor(3, 129315.000000, 79120.000000, 1478.000000, 0.0, true) -- Desert Gas Station Back Door
	CreateDoor(30, 129401.968750, 75810.203125, 1473.000000, 182.0, true) -- Desert Gas Station Gas Tanks
	
	CreateDoor(18, 211200.000000, 94175.000000, 1282.000000, -180.0, true) -- Diner Physics Door 1
	CreateDoor(18, 211308.000000, 92569.000000, 1282.000000, 0.0, true) -- Diner Physics Door 2
	
	CreateDoor(26, 97540.000000, 121148.000000, 6335.000000, 0.0, true) -- Scenic View Restroom 1
	CreateDoor(26, 96840.000000, 121148.000000, 6335.000000, 180.0, true) -- Scenic View Restroom 2
	
	-- Desert House 1 near radio tower mountain
	CreateDoor(20, 186641.968750, -41649.476563, 1417.000000, 175.0, true) -- Door Entrance
	CreateDoor(24, 186425.968750, -41678.332031, 1417.000000, 85.0, true) -- Door Interior
	CreateDoor(21, 185851.750000, -41129.601563, 1417.000000, -5.0, true) -- Door Back Door
	
	-- Desert House 2 near radio tower mountain
	CreateDoor(20, 192122.000000, -45262.136719, 1436.000000, 290.0, true) -- Door Entrance
	CreateDoor(24, 192512.546875, -45539.789063, 1436.000000, 200.0, true) -- Door Interior

	-- START PRISON GATES
	CreateDoor(5, -169639.953125, 77560.062500, 1429.000000, -180.0, true)
	CreateDoor(5, -178039.968750, 66310.062500, 1429.000000, -90.0, true)
	CreateDoor(5, -183639.968750, 81060.054688, 1429.000000, 0.0, true)
	CreateDoor(5, -185039.968750, 85260.062500, 1429.000000, 0.0, true)
	-- END PRISON GATES
	
	-- START PRISON BARRIERS
	CreateDoor(6, -170377.500000,77521.687500, 1430.000488, -90.0, true)
	CreateDoor(6, -170377.500000, 78314.453125, 1430.000488, 90.0, true)
	CreateDoor(6, -183003.406250, 85321.625000, 1430.000000, 90.0, true)
	CreateDoor(6, -183003.406250, 84525.085938, 1430.000000, -90.0, true)
	CreateDoor(6, -180144.031250, 84858.296875, 1430.000000, -90.0, true)
	CreateDoor(6, -180144.031250, 85667.890625, 1430.000000, 90.0, true)
	CreateDoor(6, -182656.843750, 80328.765625, 1430.000000, -90.0, true)
	CreateDoor(6, -182656.843750, 81125.273438, 1430.000000, 90.0, true)
	-- END PRISON BARRIERS
	
	-- START PRISON DOORS OUTSIDE
	CreateDoor(3, -170068.203125, 77587.656250, 1434.840820, 90.0, true)
	CreateDoor(1, -179133.906250, 67481.507813, 1435.000000, 180.0, true)
	CreateDoor(1, -182984.968750, 81198.992188, 1435.000000, 90.0, true)
	CreateDoor(1, -183242.906250, 84464.507813, 1435.000000, -90.0, true)
	CreateDoor(1, -178405.828125, 84532.812500, 1435.000000, -90.0, true)
	CreateDoor(4, -169602.000000, 75812.000000, 1430.000000, 0.0, true)
	CreateDoor(4, -183678.000000, 81300.000000, 1430.000000, 180.0, true)
	CreateDoor(4, -182255.000000, 79871.000000, 1430.000000, 0.0, true)
	CreateDoor(4, -180602.000000, 79396.000000, 1430.000000, 90.0, true)
	CreateDoor(4, -180602.000000, 79396.000000, 1430.000000, 90.0, true)
	CreateDoor(4, -178073.000000, 73598.000000, 1426.000000, 180.0, true)
	CreateDoor(3, -173118.000000, 75867.000000, 1530.000000, 0.0, true)
	CreateDoor(3, -171447.000000, 81782.000000, 1530.000000, 90.0, true)
	CreateDoor(3, -180863.000000, 82754.000000, 1530.000000, 180.0, true)
	CreateDoor(3, -178762.000000, 77853.000000, 1530.000000, 180.0, true)
	CreateDoor(3, -181561.000000, 75052.000000, 1530.000000, 180.0, true)
	CreateDoor(3, -175962.000000, 74353.000000, 1530.000000, 180.0, true)
	CreateDoor(4, -175533.000000, 79635.000000, 1530.000000, -90.0, true)
	-- END PRISON DOORS OUTSIDE
	
	-- START PRISON TOWER DOORS
	CreateDoor(1, -184933.000000, 85744.000000, 2485.000000, 0.0, true)
	CreateDoor(1, -184594.000000, 85721.000000, 1435.000000, 0.0, true)
	CreateDoor(1, -169034.000000, 85910.000000, 2485.000000, -90.0, true)
	CreateDoor(1, -169057.000000, 85574.000000, 1435.000000, -90.0, true)
	CreateDoor(1, -169936.000000, 74072.000000, 2485.000000, -270.0, true)
	CreateDoor(1, -169912.000000, 74406.000000, 1435.000000, 90.0, true)
	CreateDoor(1, -179206.000000, 70895.000000, 2485.000000, -90.0, true)
	CreateDoor(1, -179345.000000, 70563.000000, 1435.000000, 90.0, true)
	CreateDoor(1, -183406.000000, 79789.000000, 2685.000000, 0.0, true)
	CreateDoor(1, -183067.000000, 79766.000000, 1635.000000, 0.0, true)
	-- END PRISON TOWER DOORS
	
	-- START PRISON FENCE DOORS OUTSIDE
	CreateDoor(7, -171158.000000, 76860.000000, 1430.000000, -90.0, true)
	CreateDoor(7, -173089.000000, 74543.000000, 1429.000000, 0.0, true)
	CreateDoor(7, -170690.000000, 74542.000000, 1430.000000, 0.0, true)
	CreateDoor(7, -171036.000000, 84092.000000, 1430.000000, 0.0, true)
	CreateDoor(7, -169057.000000, 84560.000000, 1430.000000, -90.0, true)
	CreateDoor(7, -180190.000000, 84442.000000, 1430.000000, 0.0, true)
	CreateDoor(7, -181422.000000, 83260.000000, 1430.000000, 90.0, true)
	CreateDoor(7, -181422.000000, 82410.000000, 1430.000000, 90.0, true)
	CreateDoor(7, -181422.000000, 81760.000000, 1430.000000, 90.0, true)
	CreateDoor(7, -183690.000000, 81928.000000, 1430.000000, 180.0, true)
	CreateDoor(7, -182940.000000, 82892.000000, 1432.000000, 0.0, true)
	CreateDoor(7, -184122.000000, 84410.000000, 1429.000000, 90.0, true)
	CreateDoor(7, -180669.000000, 76982.000000, 1430.000000, 90.0, true)
	CreateDoor(7, -182229.000000, 75316.000000, 1430.000000, -90.0, true)
	CreateDoor(7, -182108.000000, 74024.000000, 1430.000000, -90.0, true)
	CreateDoor(7, -180090.000000, 69278.000000, 1430.000000, -180.0, true)
	CreateDoor(7, -177990.000000, 69628.000000, 1430.000000, 180.0, true)
	CreateDoor(7, -179150.000000, 69248.000000, 1430.000000, -180.0, true)
	CreateDoor(7, -177108.000000, 81660.000000, 1430.000000, -90.0, true)
	CreateDoor(7, -176408.000000, 80210.000000, 1230.000000, -90.0, true)
	CreateDoor(7, -177340.000000, 72892.000000, 1230.000000, 0.0, true)
	CreateDoor(7, -177340.000000, 72543.000000, 1230.000000, 0.0, true)
	CreateDoor(7, -177340.000000, 72192.000000, 1230.000000, 0.0, true)
	CreateDoor(7, -177340.000000, 71842.000000, 1230.000000, 0.0, true)
	CreateDoor(7, -177340.000000, 71493.000000, 1230.000000, 0.0, true)
	CreateDoor(7, -177340.000000, 71143.000000, 1230.000000, 0.0, true)
	CreateDoor(7, -176640.000000, 71378.000000, 1430.000000, 0.0, true)
	-- END PRISON FENCE DOORS OUTSIDE
	
	-- START PRISON FENCE DOORS INTERIOR
	CreateDoor(8, -179440.000000, 79773.000000, 1886.000000, 180.0, true)
	-- END PRISON FENCE DOORS INTERIOR
	
	-- START PRISON GENERIC DOORS INTERIOR
	CreateDoor(2, -173601.000000, 76147.000000, 1530.000000, -90.0, true)
	CreateDoor(2, -174428.000000, 75457.000000, 1530.000000, 90.0, true)
	CreateDoor(1, -174126.000000, 76145.000000, 1530.000000, -90.0, true)
	CreateDoor(3, -174894.000000, 76049.000000, 1530.000000, 0.0, true)
	CreateDoor(3, -175128.000000, 75457.000000, 1880.000000, 90.0, true)
	CreateDoor(1, -174778.000000, 74756.000000, 1880.000000, 90.0, true)
	CreateDoor(2, -174428.000000, 75457.000000, 1880.000000, 90.0, true)
	CreateDoor(2, -173836.000000, 75572.000000, 1880.000000, 180.0, true)
	CreateDoor(2, -173836.000000, 76272.000000, 1880.000000, 180.0, true)
	CreateDoor(9, -174054.000000, 76860.000000, 1880.000000, -90.0, true)
	CreateDoor(9, -175376.000000, 74780.000000, 1880.000000, 90.0, true)
	CreateDoor(1, -175303.000000, 74075.000000, 1880.000000, 90.0, true)
	CreateDoor(9, -175939.000000, 75245.000000, 1880.000000, 0.0, true)
	CreateDoor(9, -176155.000000, 75460.000000, 1880.000000, -90.0, true)
	CreateDoor(3, -174541.000000, 77799.000000, 1880.000000, 0.0, true)
	CreateDoor(9, -178039.000000, 75245.000000, 1880.000000, 0.0, true)
	CreateDoor(9, -178039.000000, 75245.000000, 1530.000000, 0.0, true)
	CreateDoor(9, -178254.000000, 75610.000000, 1530.000000, -90.0, true)
	CreateDoor(1, -176637.000000, 77685.000000, 1880.000000, 180.0, true)
	CreateDoor(3, -176866.000000, 76157.000000, 1880.000000, 90.0, true)
	CreateDoor(1, -176752.000000, 77896.000000, 1880.000000, -90.0, true)
	CreateDoor(1, -176994.000000, 76736.000000, 1880.000000, 0.0, true)
	CreateDoor(1, -176636.000000, 78034.000000, 1880.000000, -180.0, true)
	CreateDoor(1, -178023.000000, 78149.000000, 1881.000000, 0.0, true)
	CreateDoor(2, -178044.000000, 76378.000000, 1880.000000, 0.0, true)
	CreateDoor(1, -178042.000000, 77099.000000, 1530.000000, 0.0, true)
	CreateDoor(1, -177114.000000, 78245.000000, 1530.000000, -90.0, true)
	CreateDoor(1, -178038.000000, 78384.000000, 1530.000000, -180.0, true)
	CreateDoor(9, -174055.000000, 79660.000000, 1530.000000, -90.0, true)
	CreateDoor(4, -179678.000000, 80375.000000, 1530.000000, 90.0, true)
	CreateDoor(1, -178725.000000, 81649.000000, 1530.000000, 0.0, true)
	CreateDoor(1, -178725.000000, 81998.000000, 1530.000000, 0.0, true)
	CreateDoor(1, -178728.000000, 83749.000000, 1530.000000, 0.0, true)
	CreateDoor(1, -179214.000000, 83168.000000, 1530.000000, -90.0, true)
	CreateDoor(1, -180614.000000, 83168.000000, 1530.000000, -90.0, true)
	CreateDoor(2, -179679.000000, 83525.000000, 1530.000000, 90.0, true)
	CreateDoor(2, -180729.000000, 83525.000000, 1530.000000, 90.0, true)
	CreateDoor(2, -180235.000000, 83284.000000, 1530.000000, 180.0, true)
	CreateDoor(1, -180379.000000, 82474.000000, 1530.000000, 90.0, true)
	CreateDoor(1, -179328.000000, 82474.000000, 1530.000000, 90.0, true)
	CreateDoor(2, -180154.000000, 82234.000000, 1530.000000, 180.0, true)
	CreateDoor(2, -173838.000000, 74884.000000, 1530.000000, 180.0, true)
	CreateDoor(1, -174543.000000, 75173.000000, 1530.000000, 0.0, true)
	CreateDoor(4, -174778.000000, 74776.000000, 1530.000000, 90.0, true)
	CreateDoor(1, -175931.000000, 75174.000000, 1530.000000, 0.0, true)
	CreateDoor(9, -176154.000000, 75461.000000, 1530.000000, -90.0, true)
	CreateDoor(1, -176178.000000, 78259.000000, 1880.000000, 90.0, true)
	CreateDoor(1, -174875.000000, 71149.000000, 1530.000000, 0.0, true)
	CreateDoor(4, -171441.000000, 81057.000000, 1530.000000, 0.0, true)
	CreateDoor(1, -175303.000000, 74074.000000, 1530.000000, 90.0, true)
	CreateDoor(9, -175375.000000, 74781.000000, 1530.000000, 90.0, true)
	CreateDoor(1, -173952.000000, 78945.000000, 1880.000000, -90.0, true)
	CreateDoor(1, -174314.000000, 79648.000000, 1881.000000, -90.0, true)
	-- END PRISON GENERIC DOORS INTERIOR
	
	-- START PRISON METAL FENCE DOORS INTERIOR
	CreateDoor(10, -174290.000000, 77527.000000, 1530.000000, -90.0, true)
	CreateDoor(10, -173939.000000, 77510.000000, 1530.000000, -90.0, true)
	CreateDoor(10, -176890.000000, 75624.000000, 1530.000000, 90.0, true)
	CreateDoor(10, -177089.000000, 75657.000000, 1530.000000, 270.0, true)
	CreateDoor(10, -177311.000000, 75362.000000, 1530.000000, 0.0, true)
	CreateDoor(10, -178442.000000, 76151.000000, 1530.000000, -90.0, true)
	CreateDoor(10, -178443.000000, 76649.000000, 1530.000000, 180.0, true)
	CreateDoor(10, -178639.000000, 77500.000000, 1530.000000, 90.0, true)
	CreateDoor(10, -178042.000000, 78859.000000, 1530.000000, -90.0, true)
	CreateDoor(10, -178740.000000, 78821.000000, 1528.000000, 90.0, true)
	CreateDoor(10, -178640.000000, 81759.000000, 1530.000000, 90.0, true)
	CreateDoor(10, -178291.000000, 81862.000000, 1530.000000, 90.0, true)
	CreateDoor(10, -178469.000000, 83409.000000, 1530.000000, -90.0, true)
	CreateDoor(10, -175942.000000, 83258.976563, 1530.035889, 180.0, true)
	CreateDoor(10, -175976.000000, 83762.000000, 1530.000000, 0.0, true)
	CreateDoor(10, -174439.000000, 78774.000000, 1530.000000, 90.0, true)
	CreateDoor(10, -173940.000000, 78808.000000, 1530.000000, -90.0, true)
	CreateDoor(10, -176990.000000, 77409.000000, 1530.000000, -90.0, true)
	CreateDoor(10, -176990.000000, 77374.000000, 1530.000000, 90.0, true)
	CreateDoor(10, -174931.000000, 75360.000000, 1530.000000, 0.0, true)
	CreateDoor(10, -174898.000000, 74861.000000, 1530.000000, 180.0, true)
	CreateDoor(10, -175556.000000, 74475.000000, 1530.000000, 180.0, true)
	CreateDoor(10, -172438.000000, 80011.000000, 1530.000000, 0.0, true)
	CreateDoor(10, -172438.000000, 81058.000000, 1530.000000, 0.0, true)
	CreateDoor(10, -172749.000000, 81349.000000, 1530.000000, 0.0, true)
	CreateDoor(10, -172749.000000, 83550.000000, 1530.000000, 0.0, true)
	CreateDoor(10, -174148.000000, 78445.000000, 1886.000000, -90.0, true)
	-- END PRISON METAL FENCE DOORS INTERIOR
	
	-- START PRISON GUARDBOOTHS
	CreateDoor(1, -175032.000000, 84449.000000, 1530.000000, 0.0, true)
	CreateDoor(1, -179228.000000, 74592.000000, 1530.000000, 90.0, true)
	CreateDoor(1, -176596.000000, 76705.000000, 1530.000000, 90.0, true)
	-- END PRISON GUARDBOOTHS
	
	-- START PRISON A-BLOCK CELL DOORS (Administrative Segregation, 1st Floor)
	CreateDoor(11, -175013.000000, 73822.000000, 1535.000000, 180.0, true)
	CreateDoor(11, -175014.000000, 73472.000000, 1535.000000, 180.0, true)
	CreateDoor(11, -175013.000000, 72772.000000, 1535.000000, 180.0, true)
	CreateDoor(11, -175014.000000, 72772.000000, 1535.000000, 180.0, true)
	CreateDoor(11, -175014.000000, 72422.000000, 1535.000000, 180.0, true)
	CreateDoor(11, -175014.000000, 72072.000000, 1535.000000, 180.0, true)
	CreateDoor(11, -175014.000000, 71722.000000, 1535.000000, 180.0, true)
	CreateDoor(11, -175014.000000, 71372.000000, 1535.000000, 180.0, true)
	CreateDoor(12, -175466.000000, 73823.000000, 1535.000000, 0.0, true)
	CreateDoor(12, -175466.000000, 73472.000000, 1535.000000, 0.0, true)
	CreateDoor(12, -175466.000000, 73122.000000, 1535.000000, 0.0, true)
	CreateDoor(12, -175466.000000, 72771.000000, 1535.000000, 0.0, true)
	CreateDoor(12, -175466.000000, 72422.000000, 1535.000000, 0.0, true)
	CreateDoor(12, -175466.000000, 72072.000000, 1535.000000, 0.0, true)
	CreateDoor(12, -175466.000000, 71722.000000, 1535.000000, 0.0, true)
	CreateDoor(12, -175466.000000, 71372.000000, 1535.000000, 0.0, true)
	-- END PRISON A-BLOCK CELL DOORS
	
	-- START PRISON A-BLOCK CELL DOORS (Juvenile Wing, 2nd Floor)
	CreateDoor(11, -175013.000000, 73822.000000, 1885.000000, 180.0, true)
	CreateDoor(11, -175013.000000, 73473.000000, 1885.000000, 180.0, true)
	CreateDoor(11, -175013.000000, 73122.000000, 1885.000000, 180.0, true)
	CreateDoor(11, -175013.000000, 72772.000000, 1885.000000, 180.0, true)
	CreateDoor(11, -175013.000000, 72422.000000, 1885.000000, 180.0, true)
	CreateDoor(11, -175013.000000, 72072.000000, 1885.000000, 180.0, true)
	CreateDoor(11, -175013.000000, 71722.000000, 1885.000000, 180.0, true)
	CreateDoor(11, -175013.000000, 71372.000000, 1885.000000, 180.0, true)
	CreateDoor(12, -175467.000000, 73822.000000, 1885.000000, 0.0, true)
	CreateDoor(12, -175467.000000, 73472.000000, 1885.000000, 0.0, true)
	CreateDoor(12, -175467.000000, 72772.000000, 1885.000000, 0.0, true)
	CreateDoor(12, -175467.000000, 72422.000000, 1885.000000, 0.0, true)
	CreateDoor(12, -175467.000000, 72072.000000, 1885.000000, 0.0, true)
	CreateDoor(12, -175467.000000, 71722.000000, 1885.000000, 0.0, true)
	CreateDoor(12, -175467.000000, 71372.000000, 1885.000000, 0.0, true)
	CreateDoor(12, -175702.000000, 71033.000000, 1885.000000, 90.0, true)
	CreateDoor(12, -175352.000000, 71033.000000, 1885.000000, 90.0, true)
	CreateDoor(12, -175002.000000, 71033.000000, 1885.000000, 90.0, true)
	CreateDoor(12, -174652.000000, 71033.000000, 1885.000000, 90.0, true)
	-- END PRISON A-BLOCK CELL DOORS
	
	-- START PRISON B-BLOCK CELL DOORS
	--- 1st Floor
	CreateDoor(13, -175939.000000, 76510.000000, 1530.000000, 90.0, true)
	CreateDoor(13, -175590.000000, 76510.000000, 1530.000000, 90.0, true)
	CreateDoor(13, -175239.000000, 76510.000000, 1530.000000, 90.0, true)
	CreateDoor(13, -174890.000000, 76511.000000, 1530.000000, 180.0, true)
	CreateDoor(13, -174890.000000, 76861.000000, 1530.000000, 180.0, true)
	CreateDoor(13, -174891.000000, 77210.000000, 1530.000000, -90.0, true)
	CreateDoor(13, -175241.000000, 77210.000000, 1530.000000, -90.0, true)
	CreateDoor(13, -175591.000000, 77210.000000, 1530.000000, -90.0, true)
	CreateDoor(13, -175941.000000, 77210.000000, 1530.000000, -90.0, true)
	--- 2nd Floor
	CreateDoor(13, -175939.000000, 76510.000000, 1880.000000, 90.0, true)
	CreateDoor(13, -175590.000000, 76510.000000, 1880.000000, 90.0, true)
	CreateDoor(13, -175239.000000, 76510.000000, 1880.000000, 90.0, true)
	CreateDoor(13, -174890.000000, 76511.000000, 1880.000000, 180.0, true)
	CreateDoor(13, -174890.000000, 76861.000000, 1880.000000, 180.0, true)
	CreateDoor(13, -174891.000000, 77210.000000, 1880.000000, -90.0, true)
	CreateDoor(13, -175241.000000, 77210.000000, 1880.000000, -90.0, true)
	CreateDoor(13, -175591.000000, 77210.000000, 1880.000000, -90.0, true)
	CreateDoor(13, -175941.000000, 77210.000000, 1880.000000, -90.0, true)
	CreateDoor(13, -176291.000000, 77210.000000, 1880.000000, -90.0, true)
	-- END PRISON B-BLOCK CELL DOORS
	
	-- START PRISON C-BLOCK CELL DOORS
	--- 1st Floor
	CreateDoor(15, -178742.000000, 75610.000000, 1531.000000, -90.0, true)
	CreateDoor(16, -179437.000000, 75610.000000, 1531.000000, -90.0, true)
	CreateDoor(15, -179443.000000, 75610.000000, 1531.000000, -90.0, true)
	CreateDoor(16, -180138.000000, 75610.000000, 1531.000000, -90.0, true)
	CreateDoor(15, -180142.000000, 75610.000000, 1531.000000, -90.0, true)
	CreateDoor(16, -180838.000000, 75610.000000, 1531.000000, -90.0, true)
	CreateDoor(15, -180842.000000, 75610.000000, 1531.000000, -90.0, true)
	CreateDoor(16, -181538.000000, 75610.000000, 1531.000000, -90.0, true)
	CreateDoor(15, -181538.000000, 74610.000000, 1530.000000, 90.0, true)
	CreateDoor(16, -180841.000000, 74610.000000, 1530.000000, 90.0, true)
	CreateDoor(15, -180838.000000, 74610.000000, 1530.000000, 90.0, true)
	CreateDoor(16, -180142.000000, 74610.000000, 1530.000000, 90.0, true)
	CreateDoor(15, -180138.000000, 74610.000000, 1530.000000, 90.0, true)
	CreateDoor(16, -179442.000000, 74610.000000, 1530.000000, 90.0, true)
	CreateDoor(15, -178738.000000, 74610.000000, 1530.000000, 90.0, true)
	CreateDoor(16, -178042.000000, 74610.000000, 1530.000000, 90.0, true)
	--- 2nd Floor
	CreateDoor(15, -178742.000000, 75610.000000, 1881.000000, -90.0, true)
	CreateDoor(16, -178742.000000, 75610.000000, 1881.000000, -90.0, true)
	CreateDoor(15, -179443.000000, 75610.000000, 1881.000000, -90.0, true)
	CreateDoor(16, -180138.000000, 75610.000000, 1881.000000, -90.0, true)
	CreateDoor(15, -180142.000000, 75610.000000, 1881.000000, -90.0, true)
	CreateDoor(16, -180838.000000, 75610.000000, 1881.000000, -90.0, true)
	CreateDoor(15, -180842.000000, 75610.000000, 1881.000000, -90.0, true)
	CreateDoor(16, -181538.000000, 75610.000000, 1881.000000, -90.0, true)
	CreateDoor(15, -181538.000000, 74610.000000, 1881.000000, 90.0, true)
	CreateDoor(16, -180841.000000, 74610.000000, 1881.000000, 90.0, true)
	CreateDoor(15, -180838.000000, 74610.000000, 1881.000000, 90.0, true)
	CreateDoor(16, -180142.000000, 74610.000000, 1881.000000, 90.0, true)
	CreateDoor(15, -180138.000000, 74610.000000, 1881.000000, 90.0, true)
	CreateDoor(16, -179442.000000, 74610.000000, 1881.000000, 90.0, true)
	CreateDoor(15, -178738.000000, 74610.000000, 1881.000000, 90.0, true)
	CreateDoor(16, -178042.000000, 74610.000000, 1881.000000, 90.0, true)
	CreateDoor(16, -178738.000000, 75610.000000, 1880.000000, -90.0, true)
	CreateDoor(15, -179438.000000, 74610.000000, 1880.000000, 90.0, true)
	CreateDoor(16, -178742.000000, 74610.000000, 1880.000000, 90.0, true)
	-- END PRISON C-BLOCK CELL DOORS
	
	-- START PRISON D-BLOCK CELL DOORS
	--- 1st Floor
	CreateDoor(13, -174739.000000, 80859.000000, 1530.000000, 0.0, true)
	CreateDoor(13, -174739.000000, 81209.000000, 1530.000000, 0.0, true)
	CreateDoor(14, -174740.000000, 81211.000000, 1530.000000, 0.0, true)
	CreateDoor(14, -174740.000000, 81909.000000, 1530.000000, 0.0, true)
	CreateDoor(13, -174740.000000, 82609.000000, 1530.000000, 0.0, true)
	CreateDoor(13, -174740.000000, 83310.000000, 1530.000000, 0.0, true)
	CreateDoor(14, -174740.000000, 82610.000000, 1530.000000, 0.0, true)
	CreateDoor(14, -173697.000000, 80861.000000, 1530.000000, 0.0, true)
	CreateDoor(14, -173697.000000, 81211.000000, 1530.000000, 0.0, true)
	CreateDoor(14, -173697.000000, 81911.000000, 1530.000000, 0.0, true)
	CreateDoor(14, -173697.000000, 82611.000000, 1530.000000, 0.0, true)
	CreateDoor(14, -173697.000000, 83311.000000, 1530.000000, 0.0, true)
	CreateDoor(13, -173697.000000, 83309.000000, 1530.000000, 0.0, true)
	CreateDoor(13, -173697.000000, 82609.000000, 1530.000000, 0.0, true)
	CreateDoor(13, -173697.000000, 81909.000000, 1530.000000, 0.0, true)
	--- 2nd Floor
	CreateDoor(14, -173697.000000, 80861.000000, 1880.000000, 0.0, true)
	CreateDoor(14, -173697.000000, 81211.000000, 1880.000000, 0.0, true)
	CreateDoor(14, -173697.000000, 81911.000000, 1880.000000, 0.0, true)
	CreateDoor(14, -173697.000000, 82611.000000, 1880.000000, 0.0, true)
	CreateDoor(14, -173697.000000, 83311.000000, 1880.000000, 0.0, true)
	CreateDoor(13, -173697.000000, 83309.000000, 1880.000000, 0.0, true)
	CreateDoor(13, -173697.000000, 82609.000000, 1880.000000, 0.0, true)
	CreateDoor(13, -173697.000000, 81909.000000, 1880.000000, 0.0, true)
	-- END PRISON D-BLOCK CELL DOORS
	
	print("Door Count: "..#GetAllDoors())
end)
