if(flash_alpha > 0){
	draw_set_alpha(flash_alpha);
	draw_set_color(flash_color);
	draw_rectangle(0,0,display_get_width(), display_get_height(), false);
	draw_set_alpha(1);
	flash_alpha -= flash_speed;
}