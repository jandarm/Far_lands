extends Node

var timeStampsMedia = []
var timeStampsMic = []

var canRecordMic = false
var canClap = true
var canRecordMedia = true
var canCheck = true

var example
var guy
var tm

var tmCount

var narrator
var meterTime
var power

func _ready():
	tm = get_node("Stopwatch")
	narrator = get_node("Control/lbNarrator")
	meterTime = get_node("Control/BarTime")
	guy = get_node("Guy")
	example = get_node("Example")
	tmCount = 0
	pass 
	
# warning-ignore:unused_argument
func _process(delta):
	_paint_Time_left()
	_paint_Bar_mic()
	_paint_Bar_media()
	
	record_Mic_check()
	
	pass

func _on_Stopwatch_timeout():
	match tmCount:
		0:
			example.play()
			narrator.text = "Слушай внимательно..."
			tm.wait_time = example.stream.get_length()
			meterTime.max_value = example.stream.get_length()
			tmCount +=1
			tm.start()
		1:
			narrator.text = "А теперь повтори!"
			tm.wait_time = 5
			meterTime.max_value = 5
			tm.stop()
		_: 
			narrator.text = "Всё! Может ещё разок?"
			guy.guy_Happy()
	pass

func _paint_Time_left():
	if (meterTime.value !=100):
		meterTime.value = tm.time_left
	else:
		meterTime.value = 0
	pass


func _paint_Bar_mic():
	calculate_Power()
	get_node("Control/BarMic/lbMicDb").text = power as String
	
	get_node("Control/BarMic").value = power
	pass


func _paint_Bar_media():
	calculate_Example()
	get_node("Control/BarMedia/lbMedDb").text = power as String
	
	get_node("Control/BarMedia").value = power
	pass

func calculate_Example():
	power = stepify(AudioServer.\
	get_bus_peak_volume_right_db(AudioServer.\
	get_bus_index("Example"), 0), 0.01)
	return power

func calculate_Power():
	power = stepify(AudioServer.\
	get_bus_peak_volume_right_db(AudioServer.\
	get_bus_index("Rhythm"), 0), 0.01)
	return power


func _on_Example_finished():
	canRecordMic = true
	canRecordMedia = false
	pass

func record_Mic_check():
	if (canRecordMic):       
		calculate_Power()
		if (canClap):
			if (power > Manager.RmsRhythm && timeStampsMic.size() >= 3):
				tmCount +=1
				_on_Stopwatch_timeout()
			if (power > Manager.RmsRhythm && timeStampsMic.size() < 3):
				timeStampsMic.append(tm.time_left)
				canClap = false
		if (power < Manager.RmsRhythm):
			canClap = true
	pass

func record_Media_check():
	if (canRecordMedia):       
		calculate_Example()
		if (canCheck):
			timeStampsMedia.append(tm.time_left)
			canCheck = false
		if (power < Manager.RmsRhythm):
			canCheck = true
	pass

func timing():
	var hit
	
	pass 
