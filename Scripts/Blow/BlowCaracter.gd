extends Node2D

onready var animation = $AnimationPlayer
var is_animation_done = false

func _ready():
	animation.play("entry")

func play_animation(animation_name) -> void:
	animation.play(animation_name)

func character_blowing():
	animation.play("blowing")
	
func exercise_completed():
	animation.play("exercise_completed")

func character_talking():
	animation.play("talking")

func end_of_anim():
	if(get_parent().get_node("Trigger_scene").successful_attempts < 3):
		get_parent().get_node("Trigger_scene").state = "on"
		get_parent().get_node("Trigger_scene").interaction_time.start()
#		включаем таймер на ожидание выполения упражнения
		get_parent().get_node("Trigger_scene").waiting_time.start()
		print("я сработала")
	elif (get_parent().get_node("Trigger_scene").successful_attempts == 3):
		print("задание выполнено успешно 3 раза")
		exercise_completed()
		#задержка 2 секунды перед закрытием уровня после 3 выполнений задания
		yield(get_tree().create_timer(2.0), "timeout")
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Map/Map_scene.tscn")
	else:
		pass
