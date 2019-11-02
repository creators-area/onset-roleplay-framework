const character_template = `
<div class="ui card stacked link red">
	<div class="content">
		<div class="header">{name}</div>
		<div class="description">
			<div class="ui list">
				<div class="item">
					<i class="birthday cake icon"></i>
					<div class="content">{age}</div>
				</div>
				<div class="item">
					<i class="dollar sign icon"></i>
					<div class="content">{money}</div>
				</div>
				<div class="item">
					<i class="money bill alternate icon"></i>
					<div class="content">{bank_money}</div>
				</div>
			</div>
		</div>
	</div>
</div>`;

const create_character_template = `
<a class="ui card stacked red action-create-character" href="#">
	<div class="center aligned description">
		<i class="icon plus grey massive"></i>
	</div>
	<div class="extra content">
		<div class="center aligned">
			Create new character
		</div>
	</div>
</a>`;

$(document).ready(() => {
	for (let i = 0; i < 3; i++) {
		$('#characters').append(create_character_template);
	}
});

$(document).on('click', '#leave-server', () => {
	$('#leave-confirmation').modal({
		closable : false,
		onApprove : function() { CallEvent( 'ORF.PlayerSelection:LeaveServer' ); },
	}).modal('show');
});

$(document).on('click', '.action-create-character', () => {
	CallEvent( 'ORF.PlayerSelection:CreateCharacter' );
});

function onReceiveData( payload, other ) {
	const decoded_payload = JSON.parse(atob(payload));
	const decoded_test = atob(other);
	$('#test').text(decoded_payload.test + ' ' + decoded_test);
}