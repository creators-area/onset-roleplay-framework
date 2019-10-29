local pprint = require( 'packages/' .. GetPackageName() .. '/vendor/pprint' )
AddFunctionExport( 'pprint', function( str ) pprint( str ) end )

AddFunctionExport( 'error', function( str, ... )
	print( '[\27[31morf-error\27[0m]' .. str, table.unpack( { ... } ) )
end)

AddFunctionExport( 'warning', function( str, ... )
	print( '[\27[33morf-error\27[0m]' .. str, table.unpack( { ... } ) )
end)

AddFunctionExport( 'success', function( str, ... )
	print( '[\27[32morf-error\27[0m]' .. str, table.unpack( { ... } ) )
end)

AddFunctionExport( 'info', function( str, ... )
	print( '[\27[34morf-error\27[0m]' .. str, table.unpack( { ... } ) )
end)
