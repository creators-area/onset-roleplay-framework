function get_unix_time()
	return os.time( os.date( '!*t' ) )
end
AddFunctionExport( 'get_unix_time', get_unix_time )

function format_unix_time( time )
	return os.date( '%Y-%m-%d %H:%M:%S', time )
end
AddFunctionExport( 'format_unix_time', format_unix_time )