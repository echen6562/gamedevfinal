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