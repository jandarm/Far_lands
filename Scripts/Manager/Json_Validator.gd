extends Node

export(String, FILE, "*.json") var jsonPath

func _ready():
	pass 

func initiate_Path():
	JsonReader.levelData = JsonReader.get_info(jsonPath)
	pass
