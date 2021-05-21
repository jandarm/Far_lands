extends Node

var timeStampsMedia = []
var timeStampsMic = []
var canRecordMic = false;
var canRecordMedia = true;
var tm
var narrator
var meterTime
var power

func _ready():
	tm = get_node("Stopwatch")
	narrator = get_node("Control/lbNarrator")
	meterTime = get_node("Control/BarTime")	
	pass 
	
# warning-ignore:unused_argument
func _process(delta):
	_paint_Time_left()
	_paint_Bar_mic()
	_paint_Bar_media()
	pass

func _on_Stopwatch_timeout():
	narrator.text = "Время вышло! Попробуй ещё раз"
	pass

func _paint_Time_left():
	if (meterTime.value !=100):
		meterTime.value = tm.time_left
	else:
		meterTime.value = 0
	pass


func _paint_Bar_mic():
	power = stepify(AudioServer.\
	get_bus_peak_volume_right_db(AudioServer.\
	get_bus_index("Rhythm"), 0), 0.01)
	get_node("Control/BarMic/lbMicDb").text = power as String
	
	get_node("Control/BarMic").value = power
	pass


func _paint_Bar_media():
	power = stepify(AudioServer.\
	get_bus_peak_volume_right_db(AudioServer.\
	get_bus_index("Example"), 0), 0.01)
	get_node("Control/BarMedia/lbMedDb").text = power as String
	
	get_node("Control/BarMedia").value = power
	pass
