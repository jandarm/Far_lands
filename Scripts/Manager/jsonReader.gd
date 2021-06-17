extends Node

var levelData : Dictionary
var jsonPath = "res://Scripts/Manager/Info.json"

func _ready():
	levelData = get_info(jsonPath)
	#delete later
	Manager.route = levelData["routes"]["the best one"]
	pass
	
func get_info (file_path):
	var file = File.new()
	assert(file.file_exists(file_path))
	file.open(file_path, File.READ)
	var mass = parse_json(file.get_as_text())
	assert(mass.size()>0)
	file.close()
	return mass


func write_Path_json(name : String, value : Array):
	var file = File.new()
	file.open(jsonPath, File.READ_WRITE)
	#levelData["routes"].erase(["000"])
	levelData["routes"][name] = value
	file.store_line(to_json(levelData))
	file.close()
	pass
