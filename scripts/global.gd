extends Node

var global_coin = 0
var global_level_counter = 1
var global_is_pause = false
var global_is_fading = true
var global_mouse_sens = 0.25
signal GlobalSignalChangeScene

func global_change_scene():
	print("global change scene")
	global_level_counter = global_level_counter + 1
	
	
