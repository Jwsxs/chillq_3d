x = 28;
x = floor(x / oMap.cell_size) * oMap.cell_size;
y = 28;
y = floor(y / oMap.cell_size) * oMap.cell_size
z = 0;

mvSpeed = 1;

instance_create_layer(x, y, "Player", oCamera);