hovering = false;

flash_alpha = 0;
flash_speed = 0.05;

function screen_flash(color) {
	flash_alpha = .5;
	flash_color = color;
}

c_thunder = make_color_rgb(0,174,240);
c_shield = make_color_rgb(102,62,49);
c_heal = make_color_rgb(57,181,74);

flipping = false;
flip_speed = 0.1;
flip_progress = 0;

sprite_index = spr_card_back;