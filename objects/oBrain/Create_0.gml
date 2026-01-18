randomise();

debugMode = false;

squareAmnt = random(20);

for (var i = 0; i < squareAmnt; i++) {
    instance_create_layer(random(oMap.map_width) * oMap.cell_size, random(oMap.map_height) * oMap.cell_size, "Instances", oSquare);
}