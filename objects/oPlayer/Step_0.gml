var mv_up_key = keyboard_check(ord("W"));
var mv_down_key = keyboard_check(ord("S"));
var mv_left_key = keyboard_check(ord("A"));
var mv_right_key = keyboard_check(ord("D"));

if (mv_up_key) {
	x += dcos(oCamera.yaw);
	y -= dsin(oCamera.yaw);
}
if (mv_down_key) {
	x -= dcos(oCamera.yaw);
	y += dsin(oCamera.yaw);
}

if (mv_right_key) {
	x += dsin(oCamera.yaw);
	y += dcos(oCamera.yaw);
}
if (mv_left_key) {
	x -= dsin(oCamera.yaw);
	y -= dcos(oCamera.yaw);
}

var look_up_key = keyboard_check(vk_up);
var look_down_key = keyboard_check(vk_down);
var look_left_key = keyboard_check(vk_left);
var look_right_key = keyboard_check(vk_right);

if (look_up_key) oCamera.pitch -= -oCamera.msens * 50;
if (look_down_key) oCamera.pitch += -oCamera.msens * 50;
if (look_right_key) oCamera.yaw += -oCamera.msens * 50;
if (look_left_key) oCamera.yaw -= -oCamera.msens * 50;