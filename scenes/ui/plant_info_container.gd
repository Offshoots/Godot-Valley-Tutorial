extends Control

#This add function will add the "Plant_info" as a child inside the Vbox container
func add(plant_info: PanelContainer):
	$MarginContainer/ScrollContainer/VBoxContainer.add_child(plant_info)
