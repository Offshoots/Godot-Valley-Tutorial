extends CharacterBody2D

var direction: Vector2
var speed = 50

@onready var move_state_machine = $Animation/AnimationTree.get("parameters/MoveStateMachine/playback")


func _physics_process(_delta: float) -> void:
	get_basic_input()
	move()
	animate()

func get_basic_input():
	if Input.is_action_just_pressed("action"):
		$Animation/AnimationTree.set("parameters/ToolOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		

func move():
	direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()

func animate():
	
	#Use of State Machine for movement animations
	if direction:
		move_state_machine.travel('Walk')
		var direction_animation = Vector2(round(direction.x),round(direction.y))
		$Animation/AnimationTree.set("parameters/MoveStateMachine/Idle/blend_position", direction_animation)
		$Animation/AnimationTree.set("parameters/MoveStateMachine/Walk/blend_position", direction_animation)
		
		for animation in Data.TOOL_STATE_ANIMATIONS.values():
			$Animation/AnimationTree.set("parameters/ToolStateMachine/" + animation + "/blend_position", direction_animation)
			
		
	else:
		move_state_machine.travel('Idle')
	
	#My code for animations based only on x/y direction (that does work).
	#if direction.x == 1:
		#$Animation/AnimationTree.set("parameters/MoveStateMachine/Walk/blend_position", Vector2.RIGHT)
	#elif direction.x == -1:
		#$Animation/AnimationTree.set("parameters/MoveStateMachine/Walk/blend_position", Vector2.LEFT)
	#elif direction.y == 1:
		#$Animation/AnimationTree.set("parameters/MoveStateMachine/Walk/blend_position", Vector2.DOWN)
	#elif direction.y == -1:
		#$Animation/AnimationTree.set("parameters/MoveStateMachine/Walk/blend_position", Vector2.UP)


func tool_use_emit():
	print('tool')
