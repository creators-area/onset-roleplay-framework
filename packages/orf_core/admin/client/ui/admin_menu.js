function loadPlayers( players ) {
	players = JSON.parse(atob(players))
    
    console.log(players);

    const anim_list = $('#players');
    
    for (const player in players) {
        if (players.hasOwnProperty(player)) {
            const playerInfo = players[player];
            anim_list.append('<a data-name="' + player + '>' + player + '</a>');
        }
    }
}
