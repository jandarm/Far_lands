extends Node

func _ready():
	pass


func _go_Map():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Map/Map_scene.tscn");
	pass


func _on_Button1_pressed():
	_go_Map();
	pass


func _on_Moll_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Rhythm/Rhythm_scene.tscn")
	pass


func _on_Cave_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Blow/Exercise.tscn")
	pass


func _on_Go_back_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/MainMenu.tscn")
	pass


func _on_Button_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Users.tscn")
	pass


func _on_btnExit_pressed():
	get_tree().quit();
	pass
