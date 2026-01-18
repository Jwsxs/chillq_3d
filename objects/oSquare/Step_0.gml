var cx = floor(x / oMap.cell_size);
var cy = floor(y / oMap.cell_size);

if (cx >= 0 && cy >= 0 && cx < oMap.map_width && cy < oMap.map_height) {
    oMap.world_map[cy][cx] = 1;
}