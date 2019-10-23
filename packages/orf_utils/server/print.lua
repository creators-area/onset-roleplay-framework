local pprint = require( 'packages/' .. GetPackageName() .. '/server/vendor/pprint' )
AddFunctionExport( 'pprint', function( str ) pprint( str) end )
