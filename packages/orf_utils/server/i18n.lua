ORF = ORF or {}
ORF.Translations = {}
ORF.Lang = 'en'
local files = {}
local packages = {}

local pprint = require( 'packages/' .. GetPackageName() .. '/vendor/pprint' )

local function load_translations_configs()
	local server_config_content = get_file_content( 'server_config.json' )
	local server_config = json_decode( server_config_content )
	packages = server_config.packages
	local default_translations_config = get_file_content( 'i18n.json' )
	if ( default_translations_config == nil ) then
		return
	end
	local config = json_decode( default_translations_config )
	if ( config.language ~= nil ) then
		ORF.Lang = config.language
	end
end

local function autoload_translations()
	load_translations_configs()
	if ( #packages <= 0 ) then return end
	for i = 1, #packages do
		local package_name = packages[ i ]
		local files = get_files_in_folder( ( 'packages/%s/i18n/' ):format( package_name ) )
		for j = 1, #files do
			local file_name = files[ j ]
			local lang_file_content = get_file_content( ( 'packages/%s/i18n/%s' ):format( package_name, file_name ) )
			file_name = file_name:match( '(.+)%..+' )
			if ( lang_file_content ~= nil ) then
				files[ package_name ] = files[ package_name ] or {}
				ORF.Translations[ package_name ] = ORF.Translations[ package_name ] or {}
				files[ package_name ][ file_name ] = lang_file_content
				ORF.Translations[ package_name ][ file_name ] = json_decode( lang_file_content )
			end
		end
	end
end

AddEvent( 'OnPlayerJoin', function( player )
	CallRemoteEvent( player, 'ORF.SendDefautlLanguage', ORF.Lang )
	for k, v in pairs( files ) do
		CallRemoteEvent( player, 'ORF.OnI18nStartFile', k, v:len() )
		local offset = 1
		while ( offset < v:len() ) do
			CallRemoteEvent( player, 'ORF.OnI18nSendFileData', k, v:sub( offset, offset + 999 ) )
			offset = offset + 1000
		end
	end
	CallRemoteEvent( player, 'ORF.OnI18nReady' )
	CallEvent( 'ORF.OnI18nReady', player )
end)

autoload_translations()
