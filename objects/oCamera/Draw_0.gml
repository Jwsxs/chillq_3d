draw_set_color(c_white);
if (oBrain.debugMode) {
	var line_size = 25;
	draw_line(x, y, x + line_size * dcos(yaw), y - line_size * dsin(yaw));
}

var posX = oPlayer.x / oMap.cell_size;
var posY = oPlayer.y / oMap.cell_size;

var dirX = dcos(yaw);
var dirY = -dsin(yaw);

planeX = -dirY * .66;
planeY = dirX * .66;

var ww = window_get_width();
var wh = window_get_height()

var step = 25;

for (var px = 0; px < ww; px += step) {
	cameraX = 2 * px / ww - 1;
	rayDirX = dirX + planeX * cameraX;
	rayDirY = dirY + planeY * cameraX;
	
	deltaDistX = (rayDirX == 0) ? 100 : abs(1 / rayDirX);
	deltaDistY = (rayDirY == 0) ? 100 : abs(1 / rayDirY);

	mapX = floor(posX);
	mapY = floor(posY);
	
	sideDistX = 0;
	sideDistY = 0;
	
	stepX = 0;
	stepY = 0;
	
	side = 0;
	
	hit = 0;
	
	if (rayDirX < 0) {
		stepX = -1;
		sideDistX = (posX - mapX) * deltaDistX;
	} else {
		stepX = 1;
		sideDistX = (mapX + 1 - posX) * deltaDistX;
	}
	
	if (rayDirY < 0) {
		stepY = -1;
		sideDistY = (posY - mapY) * deltaDistY;
	} else {
		stepY = 1;
		sideDistY = (mapY + 1 - posY) * deltaDistY;
	}
	
	while (hit == 0) {
		if (sideDistX < sideDistY) {
			sideDistX += deltaDistX;
			mapX += stepX;
			side = 0;
		} else {
			sideDistY += deltaDistY;
			mapY += stepY;
			side = 1;
		}
		
		if (mapX < 0 || mapY < 0 || mapX >= oMap.map_width || mapY >= oMap.map_height) {
		    hit = 1;
		    break;
		}
		
		if (oMap.world_map[mapY][mapX] > 0) {
			hit = 1;
		}
	}
	
	perpWallDist = 0;
	
	if (side == 0) perpWallDist = (sideDistX - deltaDistX);
	else perpWallDist = (sideDistY - deltaDistY);
	
	perpWallDist = max(perpWallDist, 0.0001);
	lineHeight = (wh / perpWallDist);

	var pitch_offset = pitch * 4;
	
	drawStart = -lineHeight / 2 + wh / 2 + pitch_offset;
	drawEnd = lineHeight / 2 + wh / 2 + pitch_offset;
	
	drawStart = max(0, drawStart);
	drawEnd = min(wh, drawEnd);
	
	var maxDist = 20;
	var shade = 1 - (perpWallDist / maxDist);
	shade = clamp(shade, 0.15, 1);
	
	var baseCol = c_white;
	draw_set_color(merge_color(c_black, baseCol, shade));
	
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