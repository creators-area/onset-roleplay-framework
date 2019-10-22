local debug = ImportPackage( 'orf_debug' )
local config = ImportPackage( 'orf_config' )

AddEvent( 'OnPackageStart', function()
	local credentials = config.load( GetPackageName(), 'database' )
	-- debug.print( credentials )
end)
