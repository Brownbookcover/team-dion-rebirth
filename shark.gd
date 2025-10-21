extends CharacterBody3D

@export var shark_move_speed := 5
@export var shark_rotation_speed := 1
@export var agent_shark: NavigationAgent3D
@export var jumpscare_image: Sprite2D
var player: CharacterBody3D

var player_killed = false

var hunting_player = false
var random_position: Vector3
var wander_time: float
var target_basis: Basis

func randomize_wander():
	var nav_region=get_tree().get_nodes_in_group("nav region")[0]
	var navigation_map_rid = nav_region.get_navigation_map()
	random_position = NavigationServer3D.map_get_random_point(navigation_map_rid, 1, true) 
	agent_shark.target_position = random_position
	wander_time = randf_range(1,3)

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	var distance_between = (player.global_position - global_position).length()
	if distance_between < 100 and !player.playerSafe:
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
	# print(distance_between)
	if distance_between < 5 and !player.playerSafe:
		kill_player()
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

	var current_basis = global_transform.basis.orthonormalized()
	var smoothed_basis = current_basis.slerp(target_basis, delta * shark_rotation_speed).orthonormalized()
	
	global_transform.basis = smoothed_basis
	scale = Vector3(3, 3, 3)
	move_and_slide()


func kill_player():
	if not player_killed:
		player.die(Color.DARK_RED)
		%killplayer.play()
		print("You Died")
	player_killed = true

	# get_tree().paused = true
	#jumpscare_image.visible = true
