extends Node2D

var stateMachine

func _ready():
	stateMachine = get_node("AnimationTree").get("parameters/playback")
	
func play_animation (name):
	stateMachine.travel(name)
	pass
	
func animation_finished():
	yield($AnimationPlayer, "animation_finished")
	
func endOfRunning():
	get_parent().get_node("Trigger_scene").state = "on"
	get_parent().get_node("Trigger_scene").waiting_time.start()
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	pass # Replace with function body.
