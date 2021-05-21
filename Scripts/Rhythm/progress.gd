extends Node


func _ready():
	pass
	
func _process(delta):
	if(self.value != 100):
		self.value += 1
	else:
		self.value = 0
	pass
