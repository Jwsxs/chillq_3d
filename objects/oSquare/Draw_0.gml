var x1 = -47.5;
x1 *= dsin(oCamera.yaw);
var x2 = +47.5;
x2 *= dsin(oCamera.yaw);

var y1 = room_height / 2 + 37.5;
var y2 = room_height / 2 - 37.5;

draw_rectangle(x1, y1, x2, y2, true);