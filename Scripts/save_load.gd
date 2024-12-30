extends Node

const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
#const SECURITY_KEY = "be5738dghf"


func _ready():
	verify_save_directory(SAVE_DIR)
	SignalBus.saveGame.connect(_on_save)
	SignalBus.gameStart.connect(_on_load)

func verify_save_directory(path:String):
	DirAccess.make_dir_absolute(path)
	
func save_data(path):
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		return
		
	var data = {
		"player_data":{
			"highestClear": Global.player_data.highestClear,
			"lowestDeaths": Global.player_data.lowestDeaths,
			"currentRunClear": Global.player_data.currentRunClear,
			"currentDeaths": Global.player_data.currentDeaths,
			#"deahtsPerLevel": Global.player_data.deahtsPerLevel,
		}
	}
	
	var json_string = JSON.stringify(data, "\t")
	file.store_string(json_string)
	file.close()
	

func load_data(path: String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		if file == null:
			print(FileAccess.get_open_error())
			return
		var content = file.get_as_text()
		file.close()
		var data = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse #s as a json string: (%s)" %[path,content])	
			return
		
		Global.player_data = SaveData.new()
		Global.player_data.highestClear = data.player_data.highestClear
		Global.player_data.lowestDeaths = data.player_data.lowestDeaths
		Global.player_data.currentRunClear = data.player_data.currentRunClear
		Global.player_data.currentDeaths = data.player_data.currentDeaths
		#Global.player_data.deahtsPerLevel= data.player_data.deahtsPerLevel
	pass
	

func _on_save():
	save_data(SAVE_DIR+SAVE_FILE_NAME)
	pass
	
func _on_load():
	load_data(SAVE_DIR + SAVE_FILE_NAME)
	pass
