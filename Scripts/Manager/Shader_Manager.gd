extends Node

signal my_

func _ready():
# warning-ignore:return_value_discarded
	connect("my_", Manager, "say_How_you_feel")	
	emit_signal("my_")
	pass


func _shader_entered(var who):
	var node = get_node("Event_controll/"+who);
	node.material.set('shader_param/is_visible', true);
	pass


func _shader_exited(var who):
	var node = get_node("Event_controll/"+who);
	node.material.set('shader_param/is_visible', false);
	pass
