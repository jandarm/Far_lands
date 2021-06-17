extends Node2D

var puffer
var dog

var interaction_time
var waiting_time
var power = 0
var mic_volume = 0
var state = "off"
var successful_attempts = 0
var unsuccesful_attempts = 0

var nextlvlv_button
var refresh_button

var interaction_time_label
var waiting_label

var puffer_says

var start_ex

var can_play
var ready_to_blow_trigger = false

var rms

var sa = 0

func _ready():
	interaction_time = get_node("TimeOfInteraction")
	interaction_time_label = get_node("lTimeOfIteraction")
	waiting_time = get_node("Waiting_time")
	waiting_label = get_parent().get_node("Label")
	
	mic_volume = get_node("lMicVolume")
	
	puffer_says = get_parent().get_node("PufferSays")
	
	nextlvlv_button = get_parent().get_node("NextLvl_button")
	refresh_button = get_parent().get_node("Refresh_button")

	puffer = get_parent().get_node("Puffer")
	dog = get_parent().get_node("Dog")
	
	state = "off"
	can_play = true
	
	rms = Manager.RmsBlow

# warning-ignore:unused_argument
func _process(delta):
	if(Manager.start_ex == true && can_play):
		puffer.play_animation("Running")
		puffer.animation_finished()
		power = stepify(AudioServer.\
		get_bus_peak_volume_right_db(AudioServer.\
		get_bus_index("Blow_bus"), 0), 0.01)
		if (state == "on"):
#			waiting_label.text = stepify(waiting_time.time_left, 0) as String
			if (power > rms):
				interaction_time_label.text = stepify(interaction_time.time_left, 0.001) as String
				puffer.play_animation("Blowing")
				dog.play_animation("Blow")
				waiting_time.start()
			else:
				if not ready_to_blow_trigger:
					ready_to_blow_trigger = true
				else:	
					BlowTrigger()	
				interaction_time.start()
			mic_volume.text = power as String

func BlowTrigger():
	if(interaction_time.time_left < 4):
		Success()
	else:
		puffer_says.visible = false
		dog.play_animation("Idle")
		puffer.play_animation("Inhale")

func Success():
	successful_attempts+=1
	print("successful attempts - time of interaction: ", successful_attempts)
	if(successful_attempts<3):
		state = "off"
		puffer.play_animation("Completed_ex")
		interaction_time.stop()
		puffer.animation_finished()
		dog.animation_finished()
		Restart()
	elif (successful_attempts == 3):
		LevelCompleted()	
		
func Restart():
	state = "on"
	
func LevelCompleted():
	can_play=false
	dog.play_animation("Happy")
	puffer.play_animation("Success")
	state = "off"
	puffer_says.text = "Получилось!"
	waiting_time.stop()
	refresh_button.visible = true
	nextlvlv_button.visible = true
	
#func _on_TimeOfInteraction_timeout():
#	puffer.play_animation("Completed_ex")
#	successful_attempts+=1
#	print("successful attempts - time of interaction: ", successful_attempts)
#	if(successful_attempts<3):
#		state = "off"
#		interaction_time.stop()
#		Restart()

func _on_Waiting_time_timeout():
	puffer.play_animation("Sad")
	state="off"
	unsuccesful_attempts+=1
	print("unsuccesful_attempts ", unsuccesful_attempts, "state - ", state)
	if(unsuccesful_attempts<3):
		Restart()
	else:
		nextlvlv_button.visible = true
		Restart()
