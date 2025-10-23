extends CharacterBody3D

@onready var pivot := $Pivot
@onready var camera := $Pivot/Camera3D

@onready var pickup_raycast: RayCast3D = %PickupRaycast

@onready var helmet_model: Node3D = %HelmetPivot

@export var stats: PlayerStats
var playerSafe: bool = false

var dead: bool = false

var hovering_pickable: Pickup = null

var isCommentaryPlaying: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			pivot.rotate_y(-event.relative.x * 0.01 / stats.camera_impedance)
			camera.rotate_x(-event.relative.y * 0.01 / stats.camera_impedance)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(stats.camera_min_pitch), deg_to_rad(stats.camera_max_pitch))

func _physics_process(delta: float) -> void:
	if dead:
		$DeathFade.color = Color($DeathFade.color, $DeathFade.color.a + delta)
		
		if $DeathFade.color.a8 >= 255.0:
			await get_tree().create_timer(0.5).timeout
			get_tree().reload_current_scene()
		return
	
	if $Pivot/Camera3D/HelmetPivot/Gauge.level_float <= 0.0:
		die(Color.BLACK)
		return
	
	_handle_pickup()
	
	if not is_on_floor():
		if global_position.y > 0:
			velocity.y += stats.gravity_accel * delta
		else:
			velocity.y += stats.water_gravity_accel * delta
	
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
	
	if Input.is_action_just_pressed("player_dash") and global_position.y <= 0:
		velocity = -pivot.transform.basis.z * stats.dash_vel
		$Pivot/Camera3D/HelmetPivot/Gauge.level_float -= 0.2
	
	move_and_slide()


func _handle_pickup():
	var collision = pickup_raycast.get_collider()
	
	if collision is Pickup and collision != hovering_pickable:
		if hovering_pickable != null:
			hovering_pickable.unhover()
		
		collision.hover()
		hovering_pickable = collision
	elif collision == null and hovering_pickable != null:
		hovering_pickable.unhover()
		hovering_pickable = null
	
	if Input.is_action_just_pressed("pick_up") and hovering_pickable != null:
		var pickup_name = hovering_pickable.pickup_name
		if pickup_name != "commentary":
			hovering_pickable.get_parent().queue_free()
			hovering_pickable = null
			
			if pickup_name == "helmet":
				_equip_helmet()
			
			if pickup_name == "canister":
				$Pivot/Camera3D/HelmetPivot/Gauge.level_float = 1.0
		else:
			hovering_pickable.get_parent().play()

			%CommentaryPauseTimer.wait_time = hovering_pickable.get_parent().stream.get_length()
			%CommentaryPauseTimer.start()
			isCommentaryPlaying = true
			%Gauge.paused = true
			
			%CommentaryProgBar.show()

func die(color: Color):
	$DeathFade.color = Color(color, 0.0)
	dead = true


func _equip_helmet():
	helmet_model.visible = true
	$Pivot/Camera3D/HelmetPivot/Gauge.start_oxygen=true
	stats = load("res://Resources/PlayerStats/suit_player_stats.tres")


func _unequip_helmet():
	helmet_model.visible = false
	$Pivot/Camera3D/HelmetPivot/Gauge.start_oxygen=false
	stats = load("res://Resources/PlayerStats/default_player_stats.tres")


func _on_grass_body_entered(body: Node3D) -> void:
	# print("entered")
	if body == self:
		playerSafe = true

func _on_grass_body_exited(body: Node3D) -> void:
	if body == self:
		playerSafe = false

func _on_beach_body_entered(body: Node3D) -> void:
	if body == self:
		_unequip_helmet()
		# die(Color.WHITE)


func _on_commentary_pause_timer_timeout() -> void:
	isCommentaryPlaying = false
	%Gauge.paused = false
	
	%CommentaryProgBar.hide()
