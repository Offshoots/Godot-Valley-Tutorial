extends StaticBody2D

var coord: Vector2i
@export var res: PlantResource
var dry_days = 0

func setup(grid_coord: Vector2i, parent: Node2D):
	position = grid_coord * Data.TILE_SIZE + Vector2i(8 , 5)
	parent.add_child(self)
	coord = grid_coord
	$Sprite2D.texture = res.texture

func grow(watered: bool):
	#If the bool passed into this grow function from the Level script is true then this script is run.
	#As a reminder we passed a function that would check to see if a tile watered would resolve as true
	if watered:
		#called the grow function in the resource script, where the calculation for age takes place.
		#Pass the current sprite into the grow function
		res.grow($Sprite2D)
		dry_days = 0
	else:
		dry_days += 1
		if dry_days == 3:
			res.die($Sprite2D)
		
