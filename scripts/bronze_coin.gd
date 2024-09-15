extends Area3D


signal BronzeCoinTouch

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(0.05)


func _on_body_entered(body):
	print("Bronze Coin Collected")
	BronzeCoinTouch.emit()
	queue_free()
