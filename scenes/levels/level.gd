extends Node2D



func _on_player_tool_use(tool: Enum.Tool, pos: Vector2) -> void:
	var grid_coord: Vector2i = Vector2i(int(pos.x / Data.TILE_SIZE) , int(pos.y / Data.TILE_SIZE))
	match tool:
		Enum.Tool.HOE:
			var cell = $Layers/GrassLayer.get_cell_tile_data(grid_coord) as TileData
			#"If cell" checks if is a valid grass tile (or null) first. The "and" statement then confirmed if it is a a valid farmable tile.
			if cell and cell.get_custom_data('farmable') == true:
				$Layers/SoilLayer.set_cells_terrain_connect([grid_coord], 0, 0)
				print(grid_coord)
		Enum.Tool.WATER:
			var cell = $Layers/SoilLayer.get_cell_tile_data(grid_coord) as TileData
			#This is my version of the watering tool soil code. Clear Code says it works but is "Overkill"
			#$Layers/SoilWaterLayer.set_cells_terrain_connect([grid_coord], 0, 0)
			if cell:
				$Layers/SoilWaterLayer.set_cell(grid_coord, 0, Vector2i(randi_range(0,2), 0))
			
			print(grid_coord)
