if (oBrain.debugMode) {
    for (var i = 0; i <= window_get_width(); i += oMap.cell_size) {
    	for (var j = 0; j <= window_get_height(); j += oMap.cell_size) {
    		draw_rectangle(i, j, i + oMap.cell_size, j + oMap.cell_size, 1);
    	}
    }
}