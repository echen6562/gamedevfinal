//if the card is farther than 1 from its target
if(abs(x - target_x) > 1) {
	//move towards the target by 10%
	x = lerp(x, target_x, .1);
	//draw above other cards
	depth = -1000;
	//if the card is less than 1 from its target
} else {
	//set its x to the target as well as the depth
	x = target_x;
	depth = target_depth;
}

//if the card is farther than 1 from its target
if(abs(y - target_y) > 1) {
	//move towards the target by 10%
	y = lerp(y, target_y, .1);
	//draw above other cards
	depth = -1000;
	//if the cards is less than 1 from its target
} else {
	//set the y to the target as well as the depth
	y = target_y;
	depth = target_depth;
}

//draw the card to the target depth (this is for staggered effects)
//depth = target_depth;

//show the card's face based on its index
if(face_index == 0) {
	sprite_index = spr_thunder;
}
if(face_index == 1) {
	sprite_index = spr_shield;
}
if(face_index == 2) {
	sprite_index = spr_heal;
}

//BUT if the card is face up, just show the card back
if(!face_up) sprite_index = spr_card_back;

//draw the card
draw_sprite(sprite_index, image_index, x, y);

if(flash_alpha > 0){
	draw_set_alpha(flash_alpha);
	draw_set_color(flash_color);
	draw_rectangle(0,0,display_get_width(), display_get_height(), false);
	draw_set_alpha(1);
	flash_alpha -= flash_speed;
}