extends CharacterBody3D

@onready var head = $head
@onready var standing_collision_shape = $standing_collision_shape
@onready var crouching_collision_shape = $crouching_collision_shape
@onready var ray_cast_3d = $RayCast3D
@onready var spawn_point = $"../SpawnPoint"
@onready var player = $"."

var current_speed = 5.0
var sprinting_speed = 8.0
var walking_speed = 5.0
var crouching_speed = 3.0
var lerp_speed = 10.0
var direction = Vector3.ZERO
var crouching_depth = -0.5
const jump_velocity = 4.5
#var transitioning = false
var is_sprinting = false


#const mouse_sensitivity = 0.25



# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 10.5


func _ready():
	pass
	
	

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * global.global_mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * global.global_mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89),deg_to_rad(89))


func _physics_process(delta):
	#print(transitioning)
	print(is_on_floor())
	
	
	
	  #add this
	if Input.is_action_pressed("crouch"):
		current_speed = crouching_speed
		head.position.y = lerp(head.position.y, 1.8 + crouching_depth, delta * lerp_speed )
		standing_collision_shape.disabled = true
		crouching_collision_shape.disabled = false
	elif !ray_cast_3d.is_colliding():
		standing_collision_shape.disabled = false
		crouching_collision_shape.disabled = true
		head.position.y = lerp(head.position.y, 1.8, delta * lerp_speed )
		if Input.is_action_pressed("sprint"):
			current_speed = sprinting_speed
			is_sprinting = true
			
		else :
			current_speed = walking_speed 
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
		
			

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta * lerp_speed)
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	#if global.global_is_fading == false:	
	move_and_slide()


func _on_fade_out_ui_transitioned_to_black():
	#transitioning = true
	print("I died...")
	#queue_free()
	
	player.position = spawn_point.position
	player.rotation =  spawn_point.rotation


func _on_fade_out_ui_end_transition():
	#transitioning = false
	pass
