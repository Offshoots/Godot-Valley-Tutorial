extends Node2D

var plant_scene = preload("res://scenes/objects/plant.tscn")
var used_cells: Array[Vector2i]
@onready var player = $Objects/Player
@export var daytime_color: Gradient

#This physic function was put in the level script just for active frame debuging. 
#However this could be a very cool "Cursor" or "Aim/Reticle" in a different game.
func _physics_process(_delta: float) -> void:
	var pos = player.position + player.last_direction * 16 + Vector2(0,4)
	var grid_coord: Vector2i = Vector2i(int(pos.x / Data.TILE_SIZE) , int(pos.y / Data.TILE_SIZE))
	grid_coord.x += -1 if pos.x < 0 else 0
	grid_coord.y += -1 if pos.y < 0 else 0
	$Layers/DebugLayer.clear()
	$Layers/DebugLayer.set_cell(grid_coord, 0, Vector2i(0,0))

func _process(_delta: float) -> void:
	#Create a ratio of how much of the day has passed from 0 to 1.
	var daytime_point = 1 - ($Timers/DayTimer.time_left / $Timers/DayTimer.wait_time)
	var color = daytime_color.sample(daytime_point)
	print(daytime_point)
	$Overlay/DayTimeColor.color = color

func _on_player_tool_use(tool: Enum.Tool, pos: Vector2) -> void:
	var grid_coord: Vector2i = Vector2i(int(pos.x / Data.TILE_SIZE) , int(pos.y / Data.TILE_SIZE))
	grid_coord.x += -1 if pos.x < 0 else 0
	grid_coord.y += -1 if pos.y < 0 else 0
	var has_soil = $Layers/SoilLayer.get_cell_tile_data(grid_coord) as TileData
	match tool:
		Enum.Tool.HOE:
			var cell = $Layers/GrassLayer.get_cell_tile_data(grid_coord) as TileData
			#"If cell" checks if is a valid grass tile (or null) first. The "and" statement then confirmed if it is a a valid farmable tile.
			if cell and cell.get_custom_data('farmable') == true:
				$Layers/SoilLayer.set_cells_terrain_connect([grid_coord], 0, 0)
				print(grid_coord)
		Enum.Tool.WATER:
			
			#This is my version of the watering tool soil code. Clear Code says it works but is "Overkill"
			#$Layers/SoilWaterLayer.set_cells_terrain_connect([grid_coord], 0, 0)
			if has_soil:
				$Layers/SoilWaterLayer.set_cell(grid_coord, 0, Vector2i(randi_range(0,2), 0))
		Enum.Tool.FISH:
			var cell = $Layers/GrassLayer.get_cell_tile_data(grid_coord) as TileData
			if !cell:
				print("Water")
		Enum.Tool.SEED:
			if has_soil and grid_coord not in used_cells:
				var plant = plant_scene.instantiate()
				plant.setup(grid_coord, $Objects)
				used_cells.append(grid_coord)
		Enum.Tool.AXE, Enum.Tool.SWORD:
			for object in get_tree().get_nodes_in_group('Objects'):
				if object.position.distance_to(pos)< 20:
					object.hit(tool)
				
