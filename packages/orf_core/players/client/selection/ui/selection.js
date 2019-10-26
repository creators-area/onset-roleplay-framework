$(document).ready(function() {
	$('#leave-server').click(function(){
		$('#leave-confirmation').modal({
			closable : false,
			onApprove : function() { CallEvent( 'ORF.PlayerSelection:LeaveServer' ) }
		}).modal('show')
	})

	$('#click-here').click(function(){
		CallEvent( 'ORF.Test' )
	})
})

function onReceiveData( payload, other ) {
	const decoded_payload = JSON.parse(atob(payload))
	const decoded_test = atob(other)
	$('#test').text(decoded_payload.test + ' ' + decoded_test)
}