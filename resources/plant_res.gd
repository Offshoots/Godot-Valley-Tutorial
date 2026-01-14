class_name PlantResource extends Resource

@export var texture: Texture2D
@export var grow_speed := 1

var age: float

#passing the sprite in from the plant scene allows us to update the frame to a new "Growth" stage.
func grow(sprite: Sprite2D):
	#Cap the age at the last hframe in the sprite sheet however index for frames starts at 0 (ex 0,1,2,3), so subtrack 1 from hframes (which is 4)
	age = min(grow_speed + age, sprite.hframes - 1)
	sprite.frame = int(age)
