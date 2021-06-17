extends Node

func _ready():
	
	pass
	
func _on_NextLvl_button_pressed():
	if(Manager.whereIFrom != "res://Scenes/Map/Map_scene.tscn"):
		Manager.whereIFrom = get_tree().current_scene.filename
		var currentPosition = Manager.route.find(Manager.whereINow, Manager.lastPosition)
		if(currentPosition < Manager.route.size()-1):
# warning-ignore:return_value_discarded
			get_tree().change_scene(Manager.route[currentPosition+1])
			Manager.lastPosition += 1
		else:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Menu/MainMenu.tscn")
			Manager.lastPosition = 0
	else:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Menu/MainMenu.tscn")
		Manager.lastPosition = 0
	pass
