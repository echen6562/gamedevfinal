draw_set_color(c_white);
draw_set_font(fnt_arial);
draw_set_halign(fa_center);
draw_set_valign(fa_center);

if(global.winner == obj_player){
	draw_text(x,y-10,"Congratulations you have won");
}
else if(global.winner == obj_enemy){
	draw_text(x,y-10,"Game over you have lost");
}

draw_text(x,y+25, "Press SPACE to restart");

