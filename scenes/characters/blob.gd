extends CharacterBody2D


var direction: Vector2
var speed = 50
@onready var player = $Objects/Player

func _process(delta: float) -> void:
	var pos = player.position
	var direction_x = pos.x - position.x
	var direction_y = pos.y - position.y
	#position.x += speed * delta 
	print(direction_x)
	print(direction_y)
	
