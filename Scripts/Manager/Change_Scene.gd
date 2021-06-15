extends Node

var validator

func _ready():
	validator = get_parent().get_node("Validator")
	pass

func _go_Map():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Map/Map_scene.tscn")
	pass

func _callibrate_Me():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Callibr.tscn")
	pass

func _on_btnMap_pressed():
	validator.initiate_Path()
	print(JsonReader.levelData.routes[1].que.find("../Scenes/Example/22.json"))
	print(JsonReader.levelData)
	print("Bila callibrovka? " + Manager.is_Callibrated() as String)
	if Manager.is_Callibrated():
		_go_Map();
	else:
		_callibrate_Me()
	pass


func _on_Moll_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Rhythm/Rhythm_scene.tscn")
	pass

func _on_Cave_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Blow/Blow_scene.tscn")
	pass

func _on_Go_back_pressed():
	#emit_signal: Error calling method from signal
	# 'pressed': 'Button::_on_Go_back_pressed': 
	#Method not found..
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/MainMenu.tscn")
	pass

func _on_btnUsers_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Users.tscn")

func _on_btnExit_pressed():
	get_tree().quit()
