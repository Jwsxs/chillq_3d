draw_set_color(c_white);

if (oBrain.debugMode) {
	draw_set_halign(fa_left);
	draw_text(16, 16, $"Pitch: {pitch}\nYaw: {yaw}\n\n{fps_real}");
}