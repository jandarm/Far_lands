extends Node2D

var interaction_time
var interaction_time_label
var mic_volume
var state = "off"
var power
var noize_status
var level_progress
var character
var successful_attempts = 0
var waiting_time
var waiting_label

func _ready():
	interaction_time = get_node("TimeOfInteraction")
	interaction_time_label = get_node("lTimeOfIteraction")
	mic_volume = get_node("lMicVolume")	
	noize_status = get_node("lNoize")	
	level_progress = get_node("lLevelPassed")
	character = get_parent().get_node("Main_character")
	waiting_time = get_node("Waiting_time")
	waiting_label = get_parent().get_node("Label")
	
func _process(delta):
	power = stepify(AudioServer.\
	get_bus_peak_volume_right_db(AudioServer.\
	get_bus_index("Blow_bus"), 0), 0.01)
	if (state == "on"):
		waiting_label.text = stepify(waiting_time.time_left, 0) as String
#		переделать в сигнал timeout ???
		if(waiting_time.time_left == 0):
			EndOfWaitingTime()
		if (power > -30): 
			interaction_time_label.text = stepify(interaction_time.time_left, 0.001) as String
			character.character_blowing()
			waiting_time.start()
		if (power < -30):
			BlowTrigger()
			interaction_time.start()
		mic_volume.text = power as String
	
func BlowTrigger():
	if(interaction_time.time_left < 4):
		noize_status.text = "Noize"
		level_progress.text = "Passed"
		character.exercise_completed() 	
		character.character_talking()
		if(successful_attempts < 3):
			successful_attempts+=1
			state = "off"
	else:
		noize_status.text = "Not Noize"
		level_progress.text = "Not Passed"
		
func EndOfWaitingTime():
	state = "off"
	print("сообщение о том что время истекло")
	character.character_talking()
	waiting_time.start()
