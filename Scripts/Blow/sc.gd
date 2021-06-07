extends Node2D

var tm
var tm2
var lb
var mc
var state = "off"
var power

var noizeStatus
var levelProgress

func _ready():
	tm = get_node("Timer")
	lb = get_node("Label")
	mc = get_node("mic")	
	
	noizeStatus = get_node("lNoize")	
	levelProgress = get_node("lLevelPassed")
	pass

# warning-ignore:unused_argument
func _process(delta):
	power = stepify(AudioServer.\
	get_bus_peak_volume_right_db(AudioServer.\
	get_bus_index("Blow"), 0), 0.01)
	if (state == "on"):
		if (power > -45):
			lb.text = stepify(tm.time_left, 0.001) as String
		if (power < -45):
			BlowTrigger()
			tm.start()
		mc.text = power  as String
	pass

func _on_Button_pressed():
	state = "on"
	tm.start()
	pass
	
func BlowTrigger():
	if(tm.time_left < 4):
		noizeStatus.text = "Noize"
		levelProgress.text = "Passed"
		state = "off"
	else:
		noizeStatus.text = "Not Noize"
		levelProgress.text = "Not Passed"
	pass
