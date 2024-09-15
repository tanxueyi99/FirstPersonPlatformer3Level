extends CanvasLayer
@onready var fade_out_ui = $"."

signal TransitionedToBlack
signal EndTransition

# Called when the node enters the scene tree for the first time.
func _ready():
	fading_to_normal()
	


func fading_to_black():
	global.global_is_fading = true
	fade_out_ui.visible = true
	$AnimationPlayer.play("fade_to_black")
	

func fading_to_normal():
	global.global_is_fading = true
	fade_out_ui.visible = true
	$AnimationPlayer.play("fade_to_normal")
	



func _on_animation_player_animation_finished(anim_name):
	fade_out_ui.visible = false
	if anim_name == "fade_to_black":
		emit_signal("TransitionedToBlack")
		fading_to_normal()
	if anim_name == "fade_to_normal":
		global.global_is_fading = false
		EndTransition.emit()
		
	


func _on_death_box_player_death():
	fading_to_black()
