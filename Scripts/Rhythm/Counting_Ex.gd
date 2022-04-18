extends Node

export(Array, String, FILE, "*.wav") var Instruments = []

var player
var guy
var tm

var rng = RandomNumberGenerator.new()
var rndAmount

var attemptCount = 0
var failCount = 0
#delete
var lbRng
var lbTimes

var canPlay = false

func _ready():
	$Refresh.visible = false
	$Next.visible = false
	$Dialog.visible = true
	$Dialog.set_process(true)
	player = get_node("Player")
	guy = get_node("Guy")
	tm = get_node("Timer")
	
	lbRng = get_node("lbRng")
	lbTimes = get_node("lbTimes")
	
	if($Dialog.visible):
		yield($Dialog, "dialog_finished")
	
	pass 
	
	
# warning-ignore:unused_argument
func _process(delta):
	if(attemptCount >= 3):
		$NumberButtons.set_process(false)
		$NumberButtons.visible = false
		$Next.visible = true
		$Refresh.visible = true
		canPlay = false
		player.stop()
	if(failCount >= 5):
		$Next.visible = true
		canPlay = false
		player.stop()
	
	if (canPlay):
		pick_And_play()
		canPlay = false
		lbTimes.text = "Слушай и считай"
	pass
	
	
func pick_And_play():
	rng.randomize()
	rndAmount = rng.randi_range(1, 9)
	lbRng.text = rndAmount as String
# warning-ignore:unused_variable
	for item in range(rndAmount):
		rng.randomize()
		var instrument = rng.randi_range(0, Instruments.size()-1)
		player.stream = load(Instruments[instrument])
		player.play()
		guy.play_animation(instrument as String)
		yield($Player, "finished")
	tm.start()
	lbTimes.text = "Ну, сколько раз?"
	pass
	
func answer(var amount : int):
	if(amount == rndAmount):
		lbTimes.text = "Верно!"
		canPlay = true
		attemptCount += 1
		failCount = 0
	else:
		lbTimes.text = "Не-а, было " + rndAmount as String
		canPlay = true
		attemptCount = 0
		failCount += 1
	pass

func dialog_Finished():
	canPlay = true
	pass


func _on_Player_finished():
	pass


func _on_Timer_timeout():
	player.stop()
	guy.play_animation("0")
	canPlay = false
	failCount += 1
	rndAmount = 0
	lbTimes.text = "Тебя не дождёшься"
	canPlay = true
	pass
