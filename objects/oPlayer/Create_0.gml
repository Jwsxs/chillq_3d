x = 28;
x = floor(x / oMap.cell_size) * oMap.cell_size;
y = 28;
y = floor(y / oMap.cell_size) * oMap.cell_size
z = 0;

instance_create_layer(x, y, "Player", oCamera);