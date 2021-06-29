extends Node

func _ready():
	Manager.whereINow = get_tree().current_scene.filename
	print(Manager.whereINow)
	print(Manager.whereIFrom)
	pass

func _change_Scene(name : String):
	Manager.whereIFrom = get_tree().current_scene.filename
	match name:
# warning-ignore:return_value_discarded
		"Mole": get_tree().change_scene("res://Scenes/Rhythm/Rhythm_scene.tscn")
# warning-ignore:return_value_discarded
		"Blow": get_tree().change_scene("res://Scenes/Blow/Blow_scene.tscn")
# warning-ignore:return_value_discarded
		"Map": get_tree().change_scene("res://Scenes/Map/Map_scene.tscn")
		#ошибка в пути Users no valid symbol
# warning-ignore:return_value_discarded
		"Users": get_tree().change_scene("res://Scenes/Menu/Users.tscn")
# warning-ignore:return_value_discarded
		"Path": get_tree().change_scene("res://Scenes/Path/Path_choose_scene.tscn")
# warning-ignore:return_value_discarded
		"Count": get_tree().change_scene("res://Scenes/Rhythm/Counting_scene.tscn")
		_: print("Not associated scene path, go to _change_Scene")
	pass


func _callibrate_Me():
	Manager.whereIFrom = get_tree().current_scene.filename
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Callibr.tscn")
	pass


func _on_btnMap_pressed():
	Manager.whereIFrom = get_tree().current_scene.filename
	
	print(JsonReader.levelData["routes"]["the best one"][0])
	print("Bila callibrovka? " + Manager.is_Callibrated() as String)
	if Manager.is_Callibrated():
		_go_Map();
	else:
		_callibrate_Me()
	pass

func _go_Map():
	Manager.whereIFrom = get_tree().current_scene.filename
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Map/Map_scene.tscn")
	pass


func _on_Go_back_pressed():
	Manager.whereIFrom = get_tree().current_scene.filename
	if(Manager.whereIFrom == "res://Scenes/Map/Map_scene.tscn" || Manager.whereIFrom == "res://Scenes/Menu/Users.tscn"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Menu/MainMenu.tscn")
	else:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Map/Map_scene.tscn")
	pass


func _on_btnExit_pressed():
	get_tree().quit()
	pass
