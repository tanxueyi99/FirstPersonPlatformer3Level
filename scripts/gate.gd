extends StaticBody3D
@onready var world_1 = $".."

signal NextLevel
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	print("Next Level")
	global.global_change_scene()
	#get_tree().change_scene_to_file("res://scenes/world1.tscn")
	global.GlobalSignalChangeScene.emit()
	
