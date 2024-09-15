extends Node3D

@onready var pause_menu = $PauseMenu

@onready var current_scene = $current_scene
const level1 = preload("res://scenes/world1.tscn")








# Called when the node enters the scene tree for the first time.
func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	global.GlobalSignalChangeScene.connect(change_scene)


func change_scene():
	print("scene has change")
	print(current_scene.get_child(0))
	current_scene.get_child(0).queue_free()
	current_scene.add_child(level1.instantiate())

func _physics_process(delta):
	
	if Input.is_action_just_pressed("pause"):
		if pause_menu.visible == false && global.global_is_fading == false:
		#if get_tree().pause == false && is_ready == true:
			print("false")
			print(get_tree().paused)
			get_tree().paused = true
			#print(pause_menu.visible)
			#pause_menu.visible = true
			pause_menu.show()
			#print(pause_menu.visible)
			print(get_tree().paused)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			
			
			
			
