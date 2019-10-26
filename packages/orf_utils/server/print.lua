local pprint = require( 'packages/' .. GetPackageName() .. '/vendor/pprint' )
AddFunctionExport( 'pprint', function( str ) pprint( str ) end )
