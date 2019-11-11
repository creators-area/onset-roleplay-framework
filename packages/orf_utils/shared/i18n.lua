function translate( package, key, ... )
	if ( ORF.Translations == nil ) then return 'i18n_not_ready' end
	if ( ORF.Translations[ package ] == nil ) then return 'i18n_missing_package' end
	
	local package = ORF.Translations[ package ][ ORF.Lang ]
	if ( package == nil ) then return 'i18n_missing_default_lang_package' end

	if ( ORF.Translations[ package ][ 'en' ] ~= nil ) then
		package = ORF.Translations[ package ][ 'en' ]
	end

	if ( package[ key ] == nil ) then return 'i18n_missing_key' end
	local text = package[ key ]
	local params = {...}
	for i = 1, #params do
		text = text:gsub( '{' .. i .. '}', params[ i ] )
	end
	return text
end

AddFunctionExport( 'translate', translate )
AddFunctionExport( 't', translate )
AddFunctionExport( '_', translate )