extends AcceptDialog

func _ready():
	pass

func _on_btnDeleteUser_pressed():
	self.show()

func _on_AcceptDialog_confirmed():
	get_parent().get_node("ItemList").DeleteUser()
