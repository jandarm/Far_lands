extends Node

var levelData : Dictionary

func _ready():
	#levelData = get_info(jsonPath)
	#print(levelData.routes[1].que.find("../Scenes/Example/22.json"))
	pass
	
func get_info (file_path):
	var file = File.new()
	assert(file.file_exists(file_path))
	file.open(file_path, File.READ)
	var mass = parse_json(file.get_as_text())
	assert(mass.size()>0)
	file.close()
	#file.open(file_path, File.READ_WRITE)
	#file.seek_end(-3)
	#file.store_line("{\n\"test\" : \"test\",\n},"\
	# + "\n]" + "\n}")
	#file.close()
	return mass


func write_test(jsonPath):
	var file = File.new()
	file.open(jsonPath, File.READ_WRITE)
	levelData.routes.append({"name" : "test", "que" : ["this", "is", "test"]})
	file.store_line(to_json(levelData))
	file.close()
	pass
