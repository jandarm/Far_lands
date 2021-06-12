extends Node

var stampsMedia = []
var stampsMic = []

var canRecordMic = false
var canClap = true
var canRecordMedia = true
var canCheck = false

var example
var mole
var watch
var tm

var watchCount

var narrator
var meterTime
var power

#var animationState = "Idle"

var waitingDebug

func _ready():
	watch = get_node("Stopwatch")
	tm = get_node("ClapTime")
	narrator = get_node("Control/lbNarrator")
	meterTime = get_node("Control/BarTime")
	mole = get_node("Mole")
	example = get_node("Example")
	
	waitingDebug = get_node("WaitingDebug")
	
	watchCount = 0
	stampsMedia.clear()
	stampsMic.clear()
	pass 
	
# warning-ignore:unused_argument
func _process(delta):
	_paint_Time_left()
	_paint_Bar_mic()
	_paint_Bar_media()
	#mole.play_animation(animationState)
	
	if($Dialog.visible):
		yield($Dialog, "dialog_finished")
	
	record_Mic_check()
	record_Media_check()
	
	clap_Time_debug()
	
	pass

func _on_Stopwatch_timeout():
	match watchCount:
		0:
			example.play()
			canCheck = true
			tm.wait_time = example.stream.get_length()
			narrator.text = "Слушай внимательно..."
			watch.wait_time = example.stream.get_length()
			meterTime.max_value = example.stream.get_length()
			watchCount +=1
			watch.start()
		1:
			narrator.text = "А теперь повтори!"
			canRecordMedia = false
			watch.wait_time = 5
			meterTime.max_value = 5
			mole.play_animation("Idle")
			tm.stop()
			watch.stop()
		_: 
			tm.stop()
			narrator.text = "Всё! Может ещё разок?"
			canRecordMedia = true
			mole.play_animation("Success")
	pass


func _on_Example_finished():
	canRecordMic = true
	canRecordMedia = false
	pass


func clap_Time_debug():
	if (waitingDebug.value !=100):
		waitingDebug.value = tm.time_left
	else:
		waitingDebug.value = 0
	pass


func _on_ClapTime_timeout():
	watchCount = 0
	canRecordMedia = true
	canRecordMic = false
	stampsMedia.clear()
	stampsMic.clear()
	narrator.text = "Мы так никогда не закончим..."
	mole.play_animation("Sad")
	_on_Stopwatch_timeout()
	pass


func record_Mic_check():
	if (canRecordMic):       
		calculate_Power()
		if (power < Manager.RmsRhythm):
			canClap = true
		if (canClap):
			if (power > Manager.RmsRhythm && stampsMic.size() >= stampsMedia.size()):
				watchCount +=1
				_on_Stopwatch_timeout()
			if (power > Manager.RmsRhythm && stampsMic.size() < stampsMedia.size()):
				stampsMic.append(tm.time_left)
				tm.start()
				canClap = false
	pass


func record_Media_check():
	if (canRecordMedia):       
		calculate_Example()
		if (canCheck && power > Manager.RmsRhythm):
			stampsMedia.append(tm.time_left)
			get_node("DeleteMe").text = stampsMedia as String
			tm.start()
			canCheck = false
		if (power < Manager.RmsRhythm):
			canCheck = true
	pass


func timing():
	
	pass 


func _paint_Time_left():
	if (meterTime.value !=100):
		meterTime.value = watch.time_left
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


func dialog_Finished():
	watch.start()
	pass
