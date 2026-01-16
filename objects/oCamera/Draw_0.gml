var line_size = 25;
draw_line(x, y, x + line_size * dcos(yaw), y - line_size * dsin(yaw));

var tr_height = 200;

var tr_base_r = tr_height / sqrt(tr_height / sqrt(tr_height / 2.5));
draw_triangle(
    x, y,
	x + tr_height * dcos(yaw + tr_base_r), y - tr_height * dsin(yaw + tr_base_r),
	x + tr_height * dcos(yaw - tr_base_r), y - tr_height * dsin(yaw - tr_base_r),
	true
);