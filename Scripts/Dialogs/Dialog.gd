extends Control
 
export(String, FILE, "*.json") var dialogPath = ""
export(float) var textSpeed = 0.05
 
var dialog
 
var phraseNum = 0
var finished = false

var nm
var txt
signal dialog_finished

func _ready():
	nm = get_node("Dialog_box/Name_box/Name")
	txt = get_node("Dialog_box/Message")
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()
 
func _process(_delta):
	$Indicator.visible = finished
	if (Input.is_action_just_pressed("ui_accept")):
		if finished:
			nextPhrase()
		else:
			txt.visible_characters = len(txt.text)
 
func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
 
func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		set_process(false)
		visible = false
		Manager.start_ex = true
# warning-ignore:return_value_discarded
		connect("dialog_finished", self.owner, "dialog_Finished")
		emit_signal("dialog_finished")
		return
	
	finished = false
	
	nm.text = dialog[phraseNum]["Name"]
	txt.bbcode_text = dialog[phraseNum]["Text"]
	
	txt.visible_characters = 0
	
	
	while txt.visible_characters < len(txt.text):
		txt.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return
