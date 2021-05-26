extends Node2D

var RmsBlow
var RmsRhythm

func _ready():
	RmsBlow = 0
	RmsRhythm = -30
	pass


func say_How_you_feel():
	print("it works")
	print(RmsBlow)
	print(RmsRhythm)	
	pass


func is_Callibrated():	
	return JsonReader.levelData["isCallibrated"]

# просто комментарий

#не очень просто тест
