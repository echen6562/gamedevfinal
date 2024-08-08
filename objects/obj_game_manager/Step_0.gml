if(obj_player.hp <= 0){
	end_timer++;
	global.winner = obj_enemy;
}
else if(obj_enemy.hp <= 0){
	end_timer++;
	global.winner = obj_player;
}

if(end_timer > end_delay){
	room_goto(rm_end);
	audio_stop_all();
}