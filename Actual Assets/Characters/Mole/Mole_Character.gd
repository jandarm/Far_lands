extends Node

func _ready():
	pass

func play_animation (name):
	$AnimationPlayer.play(name)
	pass

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	$Animation.stop()
	pass
