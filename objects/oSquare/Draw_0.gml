x1 = -47.5;
x1 += room_width / 2;
x2 = +47.5;
x2 -= room_width / 2;

x1 = clamp(x1, 0, room_width);
x2 = clamp(x2, 0, room_height);

y1 = room_height / 2 + 37.5;
y2 = room_height / 2 - 37.5;

draw_rectangle(
    x1,
    y1,
    x2,
    y2,
    true
);