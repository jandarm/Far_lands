extends Control

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://DataSourse/Far_lands_BD"

var line_edit

func _ready():
	line_edit = get_node("LineEdit")
	db = SQLite.new()
	db.path = db_name

func insertIntoDB():
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	var tableName = "User"
	var dict : Dictionary = Dictionary()
	dict["Name"] = line_edit.text
	
	db.insert_row(tableName,dict)

# warning-ignore:return_value_discarded
func _on_btnAccept_pressed():
	if(line_edit.text!=""):
		insertIntoDB()
		get_tree().change_scene("res://Scenes/Menu/Users.tscn")
	else:
		
		print("ошибка")

# warning-ignore:unused_argument
func _on_LineEdit_text_entered(new_text):
	_on_btnAccept_pressed()

# warning-ignore:return_value_discarded
func _on_bntClose_pressed():
	get_tree().change_scene("res://Scenes/Menu/Users.tscn")

# warning-ignore:return_value_discarded
func _on_btnCancel_pressed():
	get_tree().change_scene("res://Scenes/Menu/Users.tscn")
