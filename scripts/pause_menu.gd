extends Control

@onready var pause_menu = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	#print("pause menu is ready")
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause") && global.global_is_pause == false:
		print(global.global_is_pause)
		global.global_is_pause = true
	elif Input.is_action_just_pressed("pause") && global.global_is_pause == true:
		print(global.global_is_pause)
		global.global_is_pause = false
		pause_menu.hide()
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#if pause_menu.visible == true:
			#print("vis true")
			
	


func _on_quit_pressed():
	get_tree().quit()


func _on_continue_pressed():
	#pause_menu.visible = false
	if global.global_is_pause == true:
		global.global_is_pause = false
		pause_menu.hide()
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		


func _on_main_menu_pressed():
	print("MainMenu button pressed")
	if global.global_is_pause == true:
		global.global_is_pause = false
		pause_menu.hide()
		get_tree().paused = false
		
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func save():
	var save_dict = {
		"number_of_coin" : global.global_coin
	}
	return save_dict

func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	# search what is JSON.stringify
	var json_string = JSON.stringify(save())
	
	save_game().store_line(json_string)


func _on_save_game_pressed():
	pass
	#save_game()
	#save()
