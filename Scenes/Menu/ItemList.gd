extends ItemList

var item_list

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://DataSourse/Far_lands_BD"

var indexOfName

func _ready():
	db = SQLite.new()
	db.path = db_name
	
	db.open_db()
	var tableName = "User"
	db.query("SELECT * FROM " + tableName +";")
	for i in range(0, db.query_result.size()):
		self.add_item(db.query_result[i]["Name"])

var userName
func _on_ItemList_item_selected(index):
	indexOfName = index
	userName = get_item_text(indexOfName)

func _on_btnSelectUser_pressed():
	if(indexOfName!=null):
		print(userName)
	else:
#		сделать чтобы не нажималось
		print("erorr")
	pass # Replace with function body.

func DeleteUser():
	var tableName = "User"
#	убираем из списка чтобы не обновляться
	remove_item(indexOfName)
#	убираем из бд
	db.query("DELETE FROM " + tableName + " WHERE Name = '" + userName + "';")
	for i in range(0, db.query_result.size()):
		self.add_item(db.query_result[i]["Name"])
	
	
