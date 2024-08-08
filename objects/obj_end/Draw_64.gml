draw_set_color(c_yellow);
draw_set_font(fnt_vinque_title);
draw_set_halign(fa_center);
draw_set_valign(fa_center);

if(global.winner == obj_player){
	draw_text(x,y-115,"Congratulations you have won");
	draw_sprite(spr_player,0,x,y-30);
}
else if(global.winner == obj_enemy){
	draw_text(x,y-115,"Game over you have lost");
	draw_sprite(spr_enemy,0,x,y-30);
}

draw_set_font(fnt_vinque_large);
draw_text(x,y+55, "Press SPACE to restart");