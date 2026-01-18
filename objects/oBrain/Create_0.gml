randomise();
instance_create_layer(x, y, "Map", oMap);

instance_create_layer(28, 28, "Player", oPlayer);

debugMode = false;

squareAmnt = random(50);

for (var i = 0; i < squareAmnt; i++) {
    instance_create_layer(random(oMap.map_width) * oMap.cell_size, random(oMap.map_height) * oMap.cell_size, "Map", oSquare);
}