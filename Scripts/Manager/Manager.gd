extends Node2D

var RmsBlow
var RmsRhythm
var start_ex = false

func _ready():
	RmsBlow = -40
	RmsRhythm = -50
	pass

func say_How_you_feel():
	print("it works")
	print(RmsBlow)
	print(RmsRhythm)
	pass


func is_Callibrated():
	return JsonReader.levelData["isCallibrated"]
