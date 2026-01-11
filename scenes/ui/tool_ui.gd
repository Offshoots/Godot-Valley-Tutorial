extends Control

const TOOL_TEXTURES = {
	Enum.Tool.AXE: preload("res://graphics/icons/axe.png"),
	Enum.Tool.HOE: preload("res://graphics/icons/hoe.png"),
	Enum.Tool.WATER: preload("res://graphics/icons/water.png"),
	Enum.Tool.SWORD: preload("res://graphics/icons/sword.png"),
	Enum.Tool.FISH: preload("res://graphics/icons/fish.png"),
	Enum.Tool.SEED: preload("res://graphics/icons/wheat.png"),}

#By preloading the Tool Texture UI scene, we will have access to the new script and functions in that scene (such as "setup" func used inside of "texture_setup" below)
var tool_texture_scene = preload("res://scenes/ui/tool_ui_texture.tscn")

func _ready() -> void:
	texture_setup(Enum.Tool.values(), TOOL_TEXTURES, $ToolContainer)
	
	
func texture_setup(enum_list: Array, textures: Dictionary, container: HBoxContainer):
	for enum_id in enum_list:
		var tool_texture = tool_texture_scene.instantiate()
		#preloaded the Texture UI scene and now using the setup func, passing in each tool via enum_id in this for loop, and textures dictionary indexed for that enum_id
		tool_texture.setup(enum_id, textures[enum_id])
		container.add_child(tool_texture)
