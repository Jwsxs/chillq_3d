x = oPlayer.x;
y = oPlayer.y;
z = oPlayer.z + 8;

if (keyboard_check(vk_shift) && keyboard_check_pressed(vk_escape))
	game_end();

window_mouse_set(window_get_width() / 2, window_get_height() / 2);

yaw += -msens * (window_mouse_get_x() - window_get_width() / 2);
pitch += msens * (window_mouse_get_y() - window_get_height() / 2);

if (yaw > 360)
	yaw = 0;
if (yaw < 0)
	yaw = 360;

pitch = clamp(pitch, -70, 80);