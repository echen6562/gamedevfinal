//switch statement is funcationally similar to a long if/else
//this allows us to make it so our states run mutually exclusively
switch(state) {
	case STATES.DEAL:
		//if the move timer has reset
		if(move_timer == 0) {
			//how many cards the player has
			var _player_num = ds_list_size(player_hand);
			var _comp_num = ds_list_size(comp_hand);
			if(_comp_num < 3) {
				var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) -1);
				ds_list_delete(deck, ds_list_size(deck) - 1);
				ds_list_add(comp_hand, _dealt_card);
				
				_dealt_card.target_x = room_width/2 - hand_x_offset + _comp_num * hand_x_offset;
				_dealt_card.target_y = room_height * 0.25;
				audio_play_sound(snd_card_move,1,0);
			}
			else if(_player_num < 3 && _comp_num == 3) {
				//grab the top card of the deck
				var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
		
				//remove the card's index from the deck
				ds_list_delete(deck, ds_list_size(deck) - 1);
				//add that card to the player's hand
				ds_list_add(player_hand, _dealt_card);
		
				//set the card's target position to the hand area
				_dealt_card.target_x = room_width/2 - hand_x_offset + _player_num * hand_x_offset;
				_dealt_card.target_y = room_height * 0.75;
				//_dealt_card.x = room_width/4 + _player_num * hand_x_offset;
				//_dealt_card.y = room_height * 0.8;
				//let the card know it's in the player's hand
				_dealt_card.in_player_hand = true;
				audio_play_sound(snd_card_move,1,0);
			} else {
				//once the player has 4 cards
				//we're no longer dealing
				state = STATES.PICK;
				for(var _i = 0; _i < _player_num; _i++){
					var player_card = ds_list_find_value(player_hand, _i);
					player_card.face_up = true;
				}
			}
		}
		break;
	case STATES.PICK:
		if(ds_list_size(comp_selected) < 1){
			comp_select_timer++;
		}
		if(ds_list_size(comp_selected) < 1 && comp_select_timer > 32){
			var comp_choice = irandom(2);
			var comp_card = comp_hand[| comp_choice];
			ds_list_add(comp_selected, comp_card);
			comp_card.target_x = room_width/2;
			comp_card.target_y = comp_card.y + comp_card.sprite_height + 15;
			comp_select_timer = 0;
			audio_play_sound(snd_card_move,1,0);
		}

		if(ds_list_size(player_selected) == 1 && ds_list_size(comp_selected) == 1) {
			for(var _i = 0; _i < ds_list_size(player_hand); _i++){
				player_hand[| _i].in_player_hand = false;
			}
			//start resolving
			state = STATES.COMPARE;
		}
		//if we're resolving but not cleaning up
		break;
	case STATES.COMPARE:
		//if the two selected cards match or do not match, tell the player in a
		//debug message
		
		compare_timer++;
		if(compare_timer > 64 && !compared){
			comp_selected[| 0].face_up = true;
			if(ds_list_find_value(comp_selected, 0).face_index == 0){
				screen_flash(c_thunder);
				audio_play_sound(snd_thunder,1,0);
				if(ds_list_find_value(player_selected, 0).face_index != 1){
					obj_player.hp -= 2;
				}
			}
			else if(ds_list_find_value(comp_selected, 0).face_index == 1){
				screen_flash(c_shield);
				audio_play_sound(snd_shield,1,0);
			}
			else if(ds_list_find_value(comp_selected, 0).face_index == 2){
				screen_flash(c_heal);
				audio_play_sound(snd_heal,1,0);
				if(obj_enemy.hp < 10){
					obj_enemy.hp += 1;
				}
			}
			if(ds_list_find_value(player_selected, 0).face_index == 0 &&
				ds_list_find_value(comp_selected, 0).face_index != 1){
				obj_enemy.hp -= 2;
			}
			compared = true;
		}
		
		if(compare_timer > 152){
			state = STATES.CLEANUP;
			compare_timer = 0;
			compared = false;
		}
		break;
	case STATES.CLEANUP:
		//find how many numbers are in the player's hand
		var _player_num = ds_list_size(player_hand);
		var _comp_num = ds_list_size(comp_hand);
		//if the player has cards
		if(move_timer == 0){
			if(ds_list_size(comp_selected) > 0){
				var _hand_card = ds_list_find_value(comp_selected, ds_list_size(comp_selected) - 1);
				for(var _i = 0; _i < ds_list_size(comp_hand); _i++){
					if(ds_list_find_value(comp_hand, _i) == _hand_card){
						ds_list_delete(comp_hand, _i);
					}
				}
			
				ds_list_delete(comp_selected, ds_list_size(comp_selected) - 1);
				ds_list_add(discard, _hand_card);
			
				//set the card's target position to the discard area
				_hand_card.target_depth = num_cards - ds_list_size(discard);
				_hand_card.depth = num_cards - ds_list_size(discard);
				_hand_card.target_x = room_width - 100;
				_hand_card.target_y = room_height/2 - (3 * ds_list_size(discard));
				audio_play_sound(snd_card_move,1,0);
			}
			else if(ds_list_size(player_selected) > 0){
				var _hand_card = ds_list_find_value(player_selected, ds_list_size(player_selected) - 1);
			
				for(var _i = 0; _i < ds_list_size(player_hand); _i++){
					if(ds_list_find_value(player_hand, _i) == _hand_card){
						ds_list_delete(player_hand, _i);
					}
				}
				ds_list_delete(player_selected, ds_list_size(player_selected) - 1);
				ds_list_add(discard, _hand_card);
			
				//set the card's target position to the discard area
				_hand_card.target_depth = num_cards - ds_list_size(discard);
				_hand_card.depth = num_cards - ds_list_size(discard);
				_hand_card.target_x = room_width - 100;
				_hand_card.target_y = room_height/2 - (3 * ds_list_size(discard));
				audio_play_sound(snd_card_move,1,0);
			}
			else if(_comp_num > 0){
				var _hand_card = ds_list_find_value(comp_hand, ds_list_size(comp_hand) - 1);
			
				//remove its index from the player's hand and add it to the discard list
				ds_list_delete(comp_hand, ds_list_size(comp_hand) - 1);
				ds_list_add(discard, _hand_card);
				_hand_card.face_up = true;
			
				//set the card's target position to the discard area
				_hand_card.target_depth = num_cards - ds_list_size(discard);
				_hand_card.depth = num_cards - ds_list_size(discard);
				_hand_card.target_x = room_width - 100;
				_hand_card.target_y = room_height/2 - (3 * ds_list_size(discard));
				audio_play_sound(snd_card_move,1,0);
			}
			else if(_player_num > 0 && _comp_num == 0) {
				//get the last card
				var _hand_card = ds_list_find_value(player_hand, ds_list_size(player_hand) - 1);
			
				//remove its index from the player's hand and add it to the discard list
				ds_list_delete(player_hand, ds_list_size(player_hand) - 1);
				ds_list_add(discard, _hand_card);
			
				//set the card's target position to the discard area
				_hand_card.target_depth = num_cards - ds_list_size(discard);
				_hand_card.depth = num_cards - ds_list_size(discard);
				_hand_card.target_x = room_width - 100;
				_hand_card.target_y = room_height/2 - (3 * ds_list_size(discard));
				audio_play_sound(snd_card_move,1,0);
			} else {
				//if the player has 0 cards
				//clear the player's selected list
				ds_list_clear(player_hand);
				ds_list_clear(comp_hand);
				ds_list_clear(player_selected);
				ds_list_clear(comp_selected);
				if(ds_list_size(deck) == 0){
					state = STATES.SHUFFLE;
				}
				else{
					state = STATES.DEAL;
				}
				//IF deck.count == 0
				//state = shuffle
				//ELSE
				//state = deal
			}
		}
		break;
    case STATES.SHUFFLE:
		if (ds_list_size(discard) > 0) {
			if(move_timer % 4 == 0){
				var card = ds_list_find_value(discard, 0);
				ds_list_delete(discard, 0);
				ds_list_add(deck, card);
				card.target_x = 100;
				card.target_y = room_height/2 - (3 * ds_list_size(deck));
				card.target_depth = num_cards - ds_list_size(deck);
				card.depth = num_cards - ds_list_size(deck);
				card.face_up = false;	
				audio_play_sound(snd_card_move,1,0);
			}
		}
		else{
			shuffle_timer++;
			if(shuffle_timer >= 24){
				if(move_timer % 4 == 0){
					var card = deck[| current_card];
					card.target_y = room_height/2 - (3*current_card);
					card.target_depth = num_cards - current_card;
					card.depth = num_cards - current_card;
					audio_play_sound(snd_card_move,1,0);
					current_card++;
				}
			
				if(current_card == ds_list_size(deck)){
					state = STATES.DEAL;
					shuffle_timer = 0;
					current_card = 0;
				}
			}
		}
        break;
}

//increment the move timer every frame
move_timer++;
//if the move timer is 16 or more
if(move_timer > 16) {
	//reset it
	//a card can move on the next frame
	move_timer = 0;
}


