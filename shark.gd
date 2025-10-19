extends CharacterBody3D

@export var shark_move_speed := 5
@export var shark_rotation_speed := 1
@export var agent_shark: NavigationAgent3D
@export var nav_region: NavigationRegion3D
@export var jumpscare_image: Sprite2D
var player: CharacterBody3D


var hunting_player = false
var random_position: Vector3
var wander_time: float
var target_basis: Basis

func randomize_wander():
	var navigation_map_rid = nav_region.get_navigation_map()
	random_position = NavigationServer3D.map_get_random_point(navigation_map_rid, 1, true) 
	agent_shark.target_position = random_position
	wander_time = randf_range(1,3)

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	var distance_between = (player.global_position - global_position).length()
	if distance_between < 30 and !player.playerSafe:
		hunting_player = true
	elif player.playerSafe:
		hunting_player = false
		
	if wander_time > 0:
			wander_time -= delta
	elif not hunting_player:
		randomize_wander()
		
	if hunting_player:
		agent_shark.target_position = player.global_position
	var next_path_position = agent_shark.get_next_path_position()
	var direction = next_path_position - global_position

	velocity = direction.normalized() * shark_move_speed

	#if direction.length_squared() > 0.001:
		#var temp_transform = global_transform.looking_at(
			#global_position + direction.normalized(), 
			#Vector3.UP, 
			#false
		#)
		#target_basis = temp_transform.basis

	# look_at(Vector3(0, player.position.y + global_position.y, 0), Vector3.UP)

	if direction.length_squared() > 0.001:
		target_basis = global_transform.looking_at(next_path_position, Vector3.UP).basis

	var current_basis = global_transform.basis
	var smoothed_basis = current_basis.slerp(target_basis, delta * shark_rotation_speed)

	global_transform.basis = smoothed_basis
	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !player.playerSafe:
		jumpscare_image.visible = true
