
// Store the original position of the card
if (position_meeting(mouse_x, mouse_y, id) && in_player_hand) {
    // If the mouse is over the card
    if (!hovering) {
        // Move the card up and set the hovering flag
        target_y -= 15;
        hovering = true;
    }
} else {
    // If the mouse is not over the card
    if (hovering) {
        // Move the card back to its original position and unset the hovering flag
        target_y += 15;
        hovering = false;
    }
}

//the manager is in the picking state
if(obj_card_manager.state == STATES.PICK) {
	//if the player has not yet selected two cards
	if(ds_list_size(obj_card_manager.player_selected) < 1) {
		//and if the card is in the player's hand and is not face up
		if(in_player_hand) {
			//mouse is over the card and the player pressed the left mouse btn
			if(position_meeting(mouse_x, mouse_y, id) && mouse_check_button_pressed(mb_left)) {
				//flip over the card and add it to the player's selected list
				ds_list_add(obj_card_manager.player_selected, id);
				id.target_x = room_width/2;
				id.target_y = id.y - id.sprite_height - 15;
				audio_play_sound(snd_card_move,1,0);
				if(id.face_index == 0) {
					screen_flash(c_thunder);
					audio_play_sound(snd_thunder,1,0);
				}
				if(id.face_index == 1) {
					screen_flash(c_shield);
					audio_play_sound(snd_shield,1,0);
				}
				if(id.face_index == 2) {
					screen_flash(c_heal);
					audio_play_sound(snd_heal,1,0);
					if(obj_player.hp < 10){
						obj_player.hp += 1;	
					}
				}
			}
		}

	}
}

