extends Node



func _ready():
	if($Dialog.visible):
		yield($Dialog, "dialog_finished")
	
	pass 
	
	
	
func dialog_Finished():
	
	pass
