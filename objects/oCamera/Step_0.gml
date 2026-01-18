x = oPlayer.x;
y = oPlayer.y;
z = oPlayer.z + 8;

if (keyboard_check(vk_shift) && keyboard_check_pressed(vk_escape))
	game_end();

var mx = window_mouse_get_x();
var my = window_mouse_get_y();

window_mouse_set(RM_HALF_WIDTH, RM_HALF_HEIGHT);

yaw += -msens * (mx - RM_HALF_WIDTH);
pitch -= msens * (my - RM_HALF_HEIGHT);

yaw = (yaw + 360) mod 360;

pitch = clamp(pitch, -300, 300);