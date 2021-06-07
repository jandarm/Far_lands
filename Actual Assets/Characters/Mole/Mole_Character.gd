extends Node

var stateMachine

func _ready():
	stateMachine = get_node("AnimationTree").get("parameters/playback")
	pass

func play_animation (name):
	#$AnimationPlayer.play(name)
	stateMachine.travel(name)
	pass