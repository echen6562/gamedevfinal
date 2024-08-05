//position of hand
hand_x_offset = 100;

//number of cards in deck
num_cards = 24;

//enum = constant (unchangable variable)
//which allows us to create our own data type
//each potential value is a state in the card game
enum STATES
{
	DEAL,
	PICK,
	COMPARE,
	CLEANUP,
	SHUFFLE
}

//set the initial state to deal
state = STATES.DEAL;

//this controls when a card can move
//from the deck to the hand
//or the hand to the discard
//or the discard to the deck
//you'll need a seperate one for when the game pauses
//to show the player information
move_timer = 0;
shuffle_timer = 0;
shuffle_step = 0;
shuffle_index = 0;
shuffle_done = false;

comp_select_timer = 0;
compare_timer = 0;
compared = false;

current_card = 0;

//lists for different card states
deck = ds_list_create();
player_hand = ds_list_create();
comp_hand = ds_list_create();
player_selected = ds_list_create();
comp_selected = ds_list_create();
discard = ds_list_create();

//create the deck
for(var _i = 0; _i < num_cards; _i++) {
	//make a card
	var _new_card = instance_create_layer(100, room_height/2 - (3 * _i), "Instances", obj_card);
	//set its face color
	//% is modulo
	//it finds the remainder of the two numbers
	//this allows us to iterate through 0, 1, 2 for the face
	_new_card.face_index = _i % 3;
	//if the card should be face up
	_new_card.face_up = false;
	//if the card is in the player's hand
	_new_card.in_player_hand = false;
	//depth the card should move to
	_new_card.depth = num_cards - _i;
	_new_card.target_depth = num_cards - _i;
	_new_card.target_x = 100;
	_new_card.target_y = room_height/2 - (3 * _i);
	//add the card to the deck
	ds_list_add(deck, _new_card);
}

//shuffle the deck
randomize();
ds_list_shuffle(deck);

//set the depth and y pos of the cards to be staggered
//to make it look like a real deck

for (var _i = 0; _i < num_cards; _i++) {
    var _shuffled_card = ds_list_find_value(deck, _i);

    _shuffled_card.target_depth = num_cards - _i;
    _shuffled_card.depth = num_cards - _i;
    _shuffled_card.target_y = room_height / 2 - (3 * _i);
    _shuffled_card.y = room_height / 2 - (3 * _i);
}

flash_alpha = 0;
flash_speed = 0.05;

function screen_flash(color) {
	flash_alpha = .5;
	flash_color = color;
}

c_thunder = make_color_rgb(0,174,240);
c_shield = make_color_rgb(102,62,49);
c_heal = make_color_rgb(57,181,74);