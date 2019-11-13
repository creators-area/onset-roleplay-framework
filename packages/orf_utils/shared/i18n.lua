function translate( package, key, ... )
	if ( ORF.Translations == nil ) then return 'i18n_not_ready' end
	if ( ORF.Translations[ package ] == nil ) then return 'i18n_missing_package' end

	local package_lang = ORF.Translations[ package ][ ORF.Lang ]
	if ( package_lang == nil ) then return 'i18n_missing_default_lang_package' end

	if ( ORF.Translations[ package ][ 'en' ] ~= nil ) then
		package_lang = ORF.Translations[ package ][ 'en' ]
	end

	if ( package_lang[ key ] == nil ) then return 'i18n_missing_key' end
	local text = package_lang[ key ]
	local params = {...}
	for i = 1, #params do
		text = text:gsub( '{' .. i .. '}', params[ i ] )
	end
	return text
end
AddFunctionExport( 'translate', translate )

function get_translations_start_with( package, start )
	if ( ORF.Translations == nil ) then return 'i18n_not_ready' end
	if ( ORF.Translations[ package ] == nil ) then return 'i18n_missing_package' end

	local package_lang = ORF.Translations[ package ][ ORF.Lang ]
	if ( package_lang == nil ) then return 'i18n_missing_default_lang_package' end

	if ( ORF.Translations[ package ][ 'en' ] ~= nil ) then
		package_lang = ORF.Translations[ package ][ 'en' ]
	end

	local t = {}
	for k, v in pairs( package_lang ) do
		if ( start_with( k, start ) ) then
			t[ k ] = v
		end
	end
	return t
end
AddFunctionExport( 'get_translations_start_with', get_translations_start_with )
