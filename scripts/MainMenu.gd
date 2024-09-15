extends Control

@onready var animation_player = $ColorRect/AnimationPlayer
@onready var color_rect = $ColorRect

var score_data = {}
var config = ConfigFile.new()

# Load data from a file.
#var err = config.load("user://scores.cfg")
var err = config.load_encrypted_pass("user://scores.cfg","platform")




# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	color_rect.visible = false
	print("printing config file")
	print(err)
	
	#I don't think need check null for config
	#if err == null:
		#print("err null")
	#else:
		#print("err not null")
	#
	
	
	
	if err != OK:
		print("errrorr")
		return
	else:
		print("err is ok")
	if config.has_section("Player1"):
		print("It have player 1")
	if config.has_section_key("Player1", "mouse_sens"):
		print("It is player1 and has mouse sens")
	print("Does it have player 3")
	if config.has_section("Player3"):
		print("yes")
	else:
		print("no")
	
	#always check for sections and section keys make sure they are there before executing the code
	
	print("config sections are")
	print(config.get_sections())
	#because it is in array, you can tap into the array like so
	print(config.get_sections()[0])
	print("get section keys")
	print(config.get_section_keys("Player1"))
	print("Encode To Text")
		#show the entire file
	print(config.encode_to_text())
	#
	print("Get value of player 1")
	print(config.get_value("Player1", "mouse_sens"))
	print("Set value of mouse_sens to global")
	global.global_mouse_sens = config.get_value("Player1", "mouse_sens")
	print(global.global_mouse_sens)
	
	#additional thing you can do is reset user config, you can erase the section using erase_section or erase_section_key
	
	
	#can use loop to get the data as well
	print("============ Before For Loop ==============")
	for section in config.get_sections():
		print("I is:")
		print(section)
		var player_sens = config.get_value(section, "mouse_sens")
		print("Player sens is:")
		print(player_sens)
		#score_data[player_name] = player_score 
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_play_pressed():
	color_rect.visible = true
	print("pressed play")
	animation_player.play("play_fade_out")
	print("fading Out")
	


func _on_option_pressed():
	get_tree().change_scene_to_file("res://scenes/option.tscn")


func _on_quit_pressed():
	get_tree().quit()



func _on_animation_player_animation_finished(anim_name):
	print("animation end")
	get_tree().change_scene_to_file("res://scenes/main.tscn")
