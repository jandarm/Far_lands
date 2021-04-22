extends Node

func _on_Go_back_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Map/Map_scene.tscn")
	pass
