extends CharacterBody3D

@onready var pivot := $Pivot
@onready var camera := $Pivot/Camera3D

@export var stats: PlayerStats
var playerSafe: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			pivot.rotate_y(-event.relative.x * 0.01 / stats.camera_impedance)
			camera.rotate_x(-event.relative.y * 0.01 / stats.camera_impedance)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += stats.gravity_accel * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = stats.jump_velocity
	
	var input_dir := Input.get_vector("player_left", "player_right", "player_forward", "player_back")
	var direction: Vector3 = (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var target_move_vel = direction * stats.max_move_vel
	
	var current_move_vel = Vector3(velocity.x, 0, velocity.z)
	
	var accel_rate: float
	if direction.length_squared() > 0:
		# Decelerate when suddenly changing direction
		if current_move_vel.dot(direction) < (current_move_vel.length() * 0.5):
			accel_rate = stats.move_decel
		else:
			accel_rate = stats.move_accel
	else:
		accel_rate = stats.move_decel
	
	var new_move_vel = current_move_vel.move_toward(target_move_vel, accel_rate * delta)
	
	velocity.x = new_move_vel.x
	velocity.z = new_move_vel.z
	
	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == self:
		playerSafe = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == self:
		playerSafe = false
