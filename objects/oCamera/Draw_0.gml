draw_set_color(c_white);
if (oBrain.debugMode) {
	var line_size = 25;
	draw_line(x, y, x + line_size * dcos(yaw), y - line_size * dsin(yaw));
}

//base da câmera
//direção
dirX = dcos(yaw);
dirY = -dsin(yaw);
//fov
planeX = -dirY * .66;
planeY = dirX * .66;

var ww = window_get_width();
var wh = window_get_height()

var step = 2;

var rayIndex = 0;
var rays = ceil(ww / step);
   
zBuffer = array_create(ceil(ww / step));
//for walls
for (var px = 0; px < ww; px += step) {
    var posX = oPlayer.x / oMap.cell_size;
    var posY = oPlayer.y / oMap.cell_size;

    cameraX = 2 * rayIndex / rays - 1;
	rayDirX = dirX + planeX * cameraX;
	rayDirY = dirY + planeY * cameraX;
	
	deltaDistX = (rayDirX == 0) ? 100 : abs(1 / rayDirX);
	deltaDistY = (rayDirY == 0) ? 100 : abs(1 / rayDirY);

    //player pos according to grid
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
	
	if (side == 0) perpWallDist = (sideDistX - deltaDistX);
	else perpWallDist = (sideDistY - deltaDistY);
	
	perpWallDist = max(perpWallDist, 0.0001);
	lineHeight = (wh / perpWallDist);

	var pitch_offset = pitch * 10; // set pitch working
	
	drawStart = -lineHeight / 2 + wh / 2 + pitch_offset;
	drawEnd = lineHeight / 2 + wh / 2 + pitch_offset;
	
	drawStart = max(0, drawStart);
	drawEnd = min(wh, drawEnd);
	
	var maxDist = 20;
	var shade = 1 - (perpWallDist / maxDist);
	shade = clamp(shade, 0, 1);
	
	var baseCol = c_white;
	draw_set_color(merge_color(c_black, baseCol, shade));
	
	if (perpWallDist < 100) draw_line(px, drawStart, px, drawEnd);
        
    zBuffer[rayIndex] = perpWallDist;
    rayIndex++;
}


//for obj
with (oEnemy) { 
    //agora não é grid, mas espaço preciso pra posição do obj
    
    //billboard sprite
    
    var objRelX = (x - oPlayer.x) / oMap.cell_size;
    var objRelY = (y - oPlayer.y) / oMap.cell_size;
    
    //world to screen point
    var det = 1 / (oCamera.planeX * oCamera.dirY - oCamera.dirX * oCamera.planeY);
    
    var transX = det * (oCamera.dirY * objRelX - oCamera.dirX * objRelY); // deslocamento lateral
    var transY = det * (-oCamera.planeY * objRelX + oCamera.planeX * objRelY); // profundidade
    
    if (transY <= 0) exit;
       
    var screenX = (ww * 0.5) * (1 + transX / transY);
      
    //if (transY >= oCamera.zBuffer[rayCol]) exit;
    
    var spriteH = abs(wh / transY);
    var spriteW = spriteH;
    
    var spriteHalfW = spriteW * .5;
    
    var drawStartX = floor(screenX - spriteHalfW);
    var drawEndX = floor(screenX + spriteHalfW);
    
    var drawY = (wh * 0.5) - (spriteH * 0.5);
    
    //pitch funcionando
    var pitch_offset = oCamera.pitch * 10;
    
    var maxDist = 20;
    var shade = 1 - (transY / maxDist)
    shade = clamp(shade, 0, 1);
    
    draw_set_colour(merge_colour(c_black, c_white, shade));
    
    //escala
    scale = (spriteH / sprite_get_height(self.sprite_index));
    
    //match com step da renderização do room, mesmo "shaders"
    for (var stripe = drawStartX; stripe < drawEndX; stripe += step) {
        var rayCol = floor(screenX / step);
        
        //só desenhar enquanto visível
        if (rayCol < 0 || rayCol >= array_length(oCamera.zBuffer)) exit;
        
        //se tiver atrás da parede, não desenha
        if (transY >= oCamera.zBuffer[rayCol]) continue;
        
        var texX = ((stripe - drawStartX) / (drawEndX - drawStartX)) * sprite_get_width(self.sprite_index);
        
        draw_sprite_part_ext(
            sEnemy,
            0,
            texX,
            0,
            1,
            sprite_height,
            stripe,
            drawY + pitch_offset,
            scale,
            scale,
            merge_colour(c_black, c_white, shade),
            1
        );
    }
}