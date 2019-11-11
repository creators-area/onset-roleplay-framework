ORF.Translations = {}
local file_transfers = {}
ORF.Lang = 'en'

AddRemoteEvent( 'ORF.SendDefautlLanguage', function( lang )
	ORF.Lang = lang
end)

AddRemoteEvent( 'ORF.OnI18nStartFile', function( package, length )
	file_transfers[ package ] = {
		length = length,
		content = ''
	}
end)

AddRemoteEvent( 'ORF.OnI18nSendFileData', function( package, data )
	file_transfers[ package ].content = file_transfers[ package ].content .. data
	if ( file_transfers[ package ].content:len() == file_transfers[ package ].length ) then
		ORF.Translations[ package ] = json_decode( file_transfers[ package ].content )
		file_transfers[ package ] = nil
	end
end)

AddRemoteEvent( 'ORF.OnI18nReady', function( package )
	CallEvent( 'ORF.OnTranslationReady' )
end)