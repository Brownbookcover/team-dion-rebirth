extends CharacterBody3D

@onready var pivot := $Pivot
@onready var camera := $Pivot/Camera3D

@export var stats: PlayerStats

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			pivot.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = stats.jump_velocity
	
	var input_dir := Input.get_vector("player_left", "player_right", "player_forward", "player_back")
	var direction = (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var target_move_vel = direction * stats.max_move_vel
	
	var current_move_vel = Vector3(velocity.x, 0, velocity.z)
	
	var new_move_vel = current_move_vel.move_toward(target_move_vel, stats.move_acc * delta)
	
	velocity.x = new_move_vel.x
	velocity.z = new_move_vel.z
	
	move_and_slide()
