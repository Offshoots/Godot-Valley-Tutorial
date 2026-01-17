class_name PlantResource extends Resource

@export var texture: Texture2D
@export var grow_speed : float = 1.0
@export var h_frames: int = 3
@export var death_max: int = 3
@export var rewared: Enum.Item
var dead_plant = preload("res://graphics/plants/stump.png")

var age: float
var death_count: int

func setup(seed_enum: Enum.Seed):
	texture = load(Data.PLANT_DATA[seed_enum]['texture'])
	grow_speed = Data.PLANT_DATA[seed_enum]['grow_speed']
	h_frames = Data.PLANT_DATA[seed_enum]['h_frames']
	death_max = Data.PLANT_DATA[seed_enum]['death_max']

#passing the sprite in from the plant scene allows us to update the frame to a new "Growth" stage.
func grow(sprite: Sprite2D):
	#Cap the age at the last hframe
	age = min(grow_speed + age, h_frames)
	sprite.frame = int(age)
	death_count = 0
	print("grow plant")

func die(sprite: Sprite2D):
	#currently a stump png
	#The new texture can be adjusted to the correct frame. Some x/y positions may 
	sprite.texture = dead_plant
	sprite.hframes = 1
	sprite.vframes = 1
	sprite.frame = 0

func decay(plant: StaticBody2D, dry_days: int):
	death_count = dry_days
	print("decay: " + str(death_count))
	if death_count >= death_max:
		plant.queue_free()

func get_complete():
	return age >= h_frames
	
