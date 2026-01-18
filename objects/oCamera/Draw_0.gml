var line_size = 25;
draw_line(x, y, x + line_size * dcos(yaw), y - line_size * dsin(yaw));

var tr_height = 200;

var tr_base_r = tr_height / sqrt(tr_height / sqrt(tr_height / 2.5));

for (var px = 0; px < window_get_width(); px++) {
	cameraX = 2 * px / window_get_width() - 1;
	rayDirX = dcos(yaw) + planeX * cameraX;
	rayDirY = -dsin(yaw) + planeY * cameraX;
	
	deltaDistX = (rayDirX == 0) ? 10000 : abs(1 / rayDirX);
	deltaDistY = (rayDirY == 0) ? 10000 : abs(1 / rayDirY);

	mapX = floor(oPlayer.x);
	mapY = floor(oPlayer.y);
	
	sideDistX = 0;
	sideDistY = 0;
	stepX = 0;
	stepY = 0;
	
	side = 0;
	
	hit = 0;
	
	if (rayDirX < 0) {
		stepX = -1;
		sideDistX = (oPlayer.x - mapX) * deltaDistX;
	} else {
		stepX = 1;
		sideDistX = (mapX + 1 - oPlayer.x) * deltaDistX;
	}
	
	if (rayDirY < 0) {
		stepY = -1;
		sideDistY = (oPlayer.y - mapY) * deltaDistY;
	} else {
		stepY = 1;
		sideDistY = (mapY + 1 - oPlayer.y) * deltaDistY;
	}
	

	
	while (hit == 0) {
		if (sideDistX < sideDistY) {
			sideDistX += deltaDistX;
			mapX += stepX;
			side = 0;
		} else {
			sideDistY += deltaDistY;
			mapY += stepY
			side = 1;
		}
		
		if (mapX < 0 || mapY < 0 ||
		    mapX >= array_length(oMap.world_map[0]) ||
		    mapY >= array_length(oMap.world_map)) {
		    hit = 1;
		    break;
		}
		
		if (oMap.world_map[mapY][mapX] == 1) {
			hit = 1;
		}
	}
	
	perpWallDist = 0;
	
	if (side == 0) perpWallDist = (sideDistX - deltaDistX);
	else perpWallDist = (sideDistY - deltaDistY);
	
	lineHeight = (window_get_height() / perpWallDist);

	drawStart = -lineHeight / 2 + window_get_height() / 2;
	drawEnd = lineHeight / 2 + window_get_height() / 2;
	
	drawStart = max(0, drawStart);
	drawEnd = min(window_get_height(), drawEnd);
	
	if (side == 1) draw_set_color(c_white);
	
	draw_line(px, drawStart, px, drawEnd);
}

/*
draw_triangle(
    x, y,
	x + tr_height * dcos(yaw + tr_base_r), y - tr_height * dsin(yaw + tr_base_r),
	x + tr_height * dcos(yaw - tr_base_r), y - tr_height * dsin(yaw - tr_base_r),
	true
);
*/

