extends Node2D

func _ready():
	pass


func _on_Cave_mouse_entered():
	var node = get_node("Event_controll/Cave");
	node.material.set('shader_param/is_visible', true);
	pass


func _on_Cave_mouse_exited():
	var node = get_node("Event_controll/Cave");
	node.material.set('shader_param/is_visible', false);
	pass



func _on_Moll_mouse_entered():
	var node = get_node("Event_controll/Moll");
	node.material.set('shader_param/is_visible', true);
	pass


func _on_Moll_mouse_exited():
	var node = get_node("Event_controll/Moll");
	node.material.set('shader_param/is_visible', false);
	pass
