extends PanelContainer

@export var res: PlantResource

func setup(new_res: PlantResource):
	res = new_res
	$HBoxContainer/IconTexture.texture = res.icon_texture
	$HBoxContainer/VBoxContainer/NameLabel.text = res.name
