draw_set_color(c_white);
draw_set_font(fnt_arial);
draw_set_halign(fa_center);
draw_set_valign(fa_center);

draw_set_color(c_red);
draw_rectangle(obj_enemy.x-100, obj_enemy.y-60, obj_enemy.x+100, obj_enemy.y-80, false);
draw_set_color(c_green);
draw_rectangle(obj_enemy.x-100, obj_enemy.y-60, obj_enemy.x+100, obj_enemy.y-80, false);

draw_set_color(c_white);
draw_text(450, obj_enemy.y-68, string(obj_enemy.hp));

draw_set_color(c_red);
draw_rectangle(obj_player.x-100, obj_player.y+60, obj_player.x+100, obj_player.y+80, false);
draw_set_color(c_green);
draw_rectangle(obj_player.x-100, obj_player.y+60, obj_player.x+100, obj_player.y+80, false);

draw_set_color(c_white);
draw_text(450, obj_player.y+72, string(obj_player.hp));