var up_key = keyboard_check(ord("W"));
var down_key = keyboard_check(ord("S"));
var left_key = keyboard_check(ord("A"));
var right_key = keyboard_check(ord("D"));

if (up_key) {
	x += dcos(oCamera.yaw);
	y -= dsin(oCamera.yaw);
}
if (down_key) {
	x -= dcos(oCamera.yaw);
	y += dsin(oCamera.yaw);
}

if (right_key) {
	x += dsin(oCamera.yaw);
	y += dcos(oCamera.yaw);
}
if (left_key) {
	x -= dsin(oCamera.yaw);
	y -= dcos(oCamera.yaw);
}