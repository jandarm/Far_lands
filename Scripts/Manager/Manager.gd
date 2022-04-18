extends Node2D

var RmsBlow
var RmsRhythm

var start_ex = false

var whereINow
var whereIFrom
var route = []
var lastPosition = 0

func _ready():
	RmsBlow = -40
	RmsRhythm = -40
	route.clear()
	pass

func say_How_you_feel():
	print("I feel good")
	print(RmsBlow)
	print(RmsRhythm)
	pass

func is_Callibrated():
	return JsonReader.levelData["isCallibrated"]
