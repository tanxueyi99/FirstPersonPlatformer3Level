extends Control

@onready var h_slider = $Panel/MarginContainer/VBoxContainer/HSlider

var config = ConfigFile.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	print("i am ready")
	h_slider.set_value_no_signal(global.global_mouse_sens)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save():
	var save_dict = {
		"number_of_coin" : global.global_coin,
		"health" : "10",
		"array_of_items" : ["apple","banana", "orange"]
	}
	return save_dict

func save_game():
	var save_game = FileAccess.open_encrypted_with_pass("user://savegame.save", FileAccess.WRITE, "platform")
	#var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	# search what is JSON.stringify
	# turn Godot "Variant" aka dictionary to Json string
	var json_string = JSON.stringify(save())
	
	save_game.store_line(json_string)



func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_h_slider_value_changed(value):
	print("value change")
	global.global_mouse_sens = value
	#value = value
	config.set_value("Player1","mouse_sens",value)
	config.set_value("Player1","gaming_sens",10)
	config.set_value("Player2","mouse_sens",value)
	config.set_value("Player2","gaming_sens",20)
	#config.save("user://scores.cfg")
	config.save_encrypted_pass("user://scores.cfg","platform")


func _on_save_pressed():
	print("Save pressed")
	save_game()


func _on_load_pressed():
	
	print("on load")
	if not FileAccess.file_exists("user://savegame.save"):
		print("Save file does not exist")
		return
	#var file := FileAccess.open("user://savegame.save", FileAccess.READ)
	var file := FileAccess.open_encrypted_with_pass("user://savegame.save", FileAccess.READ, "platform")
	print(file)
	#In the future need to check if file = null
	if file == null:
		print("it is null")
		return
	print("continue operation")
	
	
	print(file.get_position())
	print(file.get_length())
	var json := JSON.new()
	print(json)
	
	#turn JSON to Dictionary
	json.parse(file.get_line())
	print(json)
	var save_dict := json.get_data() as Dictionary
	
	print(save_dict)
	#if not FileAccess.file_exists("user://savegame.save"):
		#return
	#var save_game = FileAccess.open("user://savegame.save",FileAccess.READ)
	#print(save_game)
	#print("=========================")
	#var json_string = save_game.get_line()
	#print(save_game.get_line())
	#var json = JSON.new()
	#print(json)
	#
#
	##turn Json string to Godot's "Variant" aka Dictionary
	#var parse_result = json.parse_string(json_string)
	#print(parse_result)
	#
	#if parse_result is Dictionary:
		#print("Is dictionary")
	#else:
		#print("It is not")
	#
	##access Godot's "variant" aka dictionary using . notation
	#print(parse_result.health)
	#global.global_coin = parse_result.number_of_coin
	#print(parse_result.number_of_coin)
	#print(parse_result.array_of_items[1])
	#var node_data = json.get_data()
	#print(node_data)
	#print("=========================")
	
	
	


func _on_delete_save_game_pressed():
	print("deleting save game..")
	if not FileAccess.file_exists("user://savegame.save"):
		print("Save file does not exist")
		return
	#var dir = DirAccess.get_directories_at("user://savegame.save")
	#var dir = DirAccess.dir_exists_absolute("user://savegame.save")
	#print(dir)
	
	DirAccess.remove_absolute("user://savegame.save")
	
