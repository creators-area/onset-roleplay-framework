local niceColors = {
    0xFF0000,
    0xFF0066,
    0xEF00FF,
    0x8000FF,
    0x1100FF,
    0x004DFF,
    0x00B3FF,
    0x00FFD5,
    0x00FF77,
    0x00FF1A,
    0x55FF00,
    0xEFFF00,
    0xFFBC00,
    0xFFA200,
    0x915425
}

local function RGB2HEX( r, g, b )
    local hexadecimal = '#'
    
    local rgb = {r, g, b}

	for key = 1, #rgb do
	    local value = rgb[ key ] 
		local hex = ''

		while ( value > 0 ) do
			local index = math.fmod( value, 16 ) + 1
			value = math.floor( value / 16 )
			hex = string.sub( '0123456789ABCDEF', index, index ) .. hex			
		end

		if ( string.len( hex ) == 0 ) then
			hex = '00'
		elseif ( string.len( hex ) == 1 ) then
			hex = '0' .. hex
        end
        
		hexadecimal = hexadecimal .. hex
	end

	return hexadecimal
end

AddFunctionExport( 'RGB2HEX', RGB2HEX )

local function RandomColor()
	return niceColors[ math.random( #niceColors ) ]
end

AddFunctionExport( 'RandomColor', RandomColor )
