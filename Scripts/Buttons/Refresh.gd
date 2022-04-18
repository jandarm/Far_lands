extends Node

func _ready():
	pass

func _on_Refresh_button_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	pass
