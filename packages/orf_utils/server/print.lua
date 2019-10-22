local pprint = require( 'packages/' .. GetPackageName() .. '/server/vendor/pprint' )

function orf_print( text )
	pprint( text )
end
AddFunctionExport( 'orf_print', orf_print )
