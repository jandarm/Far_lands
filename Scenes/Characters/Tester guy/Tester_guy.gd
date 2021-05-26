extends Node

func _ready():
	pass
	
func  guy_Sad ():
	get_node("Sprite").texture = load("res://Actual Assets/Characters/Tester_guy/Tester_guy_sad.png")
	pass

func  guy_Happy ():
	get_node("Sprite").texture = load("res://Actual Assets/Characters/Tester_guy/Tester_guy_happy.png")
	pass
	
func  guy_Neutral ():
	get_node("Sprite").texture = load("res://Actual Assets/Characters/Tester_guy/Tester_guy_neutral.png")
	pass
