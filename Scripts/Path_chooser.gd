extends Node


func _ready():
	$CurtainBottom.visible = true
	$CurtainTop.visible = false
	pass 


func _on_CheckButton_toggled(button_pressed):
	if($CurtainBottom.visible):
		$CurtainBottom.visible = false
		$CurtainTop.visible = true
	else:
		$CurtainBottom.visible = true
		$CurtainTop.visible = false
	pass
