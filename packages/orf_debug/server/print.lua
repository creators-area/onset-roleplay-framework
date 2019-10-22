local PREFIX = '[ORF]'

function print( text )
	-- TODO: Handle special case like table
	print( PREFIX .. ' ' .. tostring( text ) )
end
AddFunctionExport( 'print', print )
