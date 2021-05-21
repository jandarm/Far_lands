extends Node

var label_lime_left
var timer_time_left
var do_something

func _ready():
	label_lime_left = get_node("label_time_left")
	timer_time_left = get_node("timer_time_left")
	do_something = get_node("label_do_something")
	pass

func _process(delta):
	do_something.text = "молчи" 
	do_something.visible = true 
	label_lime_left.text = stepify(timer_time_left.time_left, 1) as String
	
	if(timer_time_left.time_left == 0):
			do_something.visible = false
			timer_time_left.start()
			
	pass
