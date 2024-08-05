draw_set_font(fnt_arial);
draw_set_halign(fa_center);
draw_set_valign(fa_center);

draw_set_color(c_red);
draw_rectangle(obj_enemy.x - 100, obj_enemy.y - 60, obj_enemy.x + 100, obj_enemy.y - 80, false);

var enemy_health_ratio = obj_enemy.hp / 10;
draw_set_color(c_green);
draw_rectangle(obj_enemy.x - 100, obj_enemy.y - 60, obj_enemy.x - 100 + 200 * enemy_health_ratio, obj_enemy.y - 80, false);

draw_set_color(c_white);
draw_text(obj_enemy.x, obj_enemy.y - 68, string(obj_enemy.hp));

draw_set_color(c_red);
draw_rectangle(obj_player.x - 100, obj_player.y + 60, obj_player.x + 100, obj_player.y + 80, false);

var player_health_ratio = obj_player.hp / 10;
draw_set_color(c_green);
draw_rectangle(obj_player.x - 100, obj_player.y + 60, obj_player.x - 100 + 200 * player_health_ratio, obj_player.y + 80, false);

draw_set_color(c_white);
draw_text(obj_player.x, obj_player.y + 72, string(obj_player.hp));