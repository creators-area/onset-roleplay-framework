local PREFIX = '[ORF]'

local function print( text )
	-- TODO: Handle special case like table
	print( PREFIX .. ' ' .. tostring( text ) )
end
AddFunctionExport( 'print', print )
