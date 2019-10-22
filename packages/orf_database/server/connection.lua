local debug = ImportPackage( 'orf_debug' )
local ini_files = ImportPackage( 'orf_ini_files' )

local CONFIG_FILE = 'config.ini'

AddEvent( 'OnPackageStart', function()
	local credentials = ini_files.load( GetPackageName(), CONFIG_FILE, 'database' )
	debug.print( credentials )
end)
