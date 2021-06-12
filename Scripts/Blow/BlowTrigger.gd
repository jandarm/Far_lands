extends Node2D

var interaction_time
var interaction_time_label
var mic_volume
var state = "off"
var power
var level_progress
var character
var successful_attempts = 0
var unsuccesful_attempts = 0
var waiting_time
var waiting_label
var nextlvlv_button
var refresh_button

func _ready():
	interaction_time = get_node("TimeOfInteraction")
	interaction_time_label = get_node("lTimeOfIteraction")
	mic_volume = get_node("lMicVolume")	
	level_progress = get_node("lLevelPassed")
	character = get_parent().get_node("Main_character")
	waiting_time = get_node("Waiting_time")
	waiting_label = get_parent().get_node("Label")
	nextlvlv_button = get_parent().get_node("NextLvl_button")
	refresh_button = get_parent().get_node("Refresh_button")
	
func _process(delta):
	power = stepify(AudioServer.\
	get_bus_peak_volume_right_db(AudioServer.\
	get_bus_index("Blow_bus"), 0), 0.01)
	if (state == "on"):
		waiting_label.text = stepify(waiting_time.time_left, 0) as String
		if(waiting_time.time_left == 0):
			EndOfWaitingTime()
		if (power > Manager.RmsBlow): 
			interaction_time_label.text = stepify(interaction_time.time_left, 0.001) as String
			character.character_blowing()
			waiting_time.start()
		if (power < Manager.RmsBlow):
			BlowTrigger()
			interaction_time.start()
		mic_volume.text = power as String
	
func BlowTrigger():
	if(interaction_time.time_left < 4):
		level_progress.text = "Passed"
		character.exercise_completed() 	
		character.character_talking()
		if(successful_attempts < 3):
			successful_attempts+=1
			state = "off"
	else:
#		это выполняется буквально все время после начала 
		level_progress.text = "Not Passed"
		
func EndOfWaitingTime():
	unsuccesful_attempts+=1
	if(unsuccesful_attempts<4):
		state = "off"
		waiting_label.text = "Ну-же попробуй!"
		Restart()
	else:
		nextlvlv_button.visible = true
		waiting_label.text = "Ну-же попробуй!"
		Restart()

func Restart():
	character.character_talking()
	waiting_time.start()
	interaction_time.start()

func _on_TimeOfInteraction_timeout():
	successful_attempts+=1
	if(successful_attempts< 3):
		state = "off"
		interaction_time.stop()
		Restart()

func LevelCompleted():
	state = "off"
	waiting_label.text = "Всё!"
	refresh_button.visible = true
	character.animation.stop()
	print("Уровень пройден кнопка пройти заново доступна")
	
