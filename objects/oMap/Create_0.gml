cell_size = 32;

map_width = room_width div cell_size;
map_height = room_height div cell_size;

world_map = array_create(map_height);

for (var yy = 0; yy < map_height; yy++) {
    world_map[yy] = array_create(map_width, 0);
}

/*
for (var i = 0; i < map_width; i++) {
    world_map[0][i] = 1;
    world_map[map_height - 1][i] = 1;
}

for (var i = 0; i < map_height; i++) {
    world_map[i][0] = 1;
    world_map[i][map_width - 1] = 1;
}
*/