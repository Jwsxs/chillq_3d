x = oPlayer.x;
y = oPlayer.y;
z = oPlayer.z + 8;

if (keyboard_check(vk_shift) && keyboard_check_pressed(vk_escape))
	game_end();

window_mouse_set(RM_HALF_WIDTH, RM_HALF_HEIGHT);

yaw += -msens * (window_mouse_get_x() - RM_HALF_WIDTH);
pitch += msens * (window_mouse_get_y() - RM_HALF_WIDTH);

if (yaw > 360)
	yaw = 0;
if (yaw < 0)
	yaw = 360;

pitch = clamp(pitch, -70, 80);