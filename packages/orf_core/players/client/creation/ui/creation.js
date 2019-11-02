function onReceiveData( payload, other ) {
	const decoded_payload = JSON.parse(atob(payload))
	const decoded_test = atob(other)
	$('#test').text(decoded_payload.test + ' ' + decoded_test)
}