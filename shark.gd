extends CharacterBody3D

@export var shark_move_speed := 5
@export var agent_shark: NavigationAgent3D
@export var jumpscare_image: Sprite2D
var player: CharacterBody3D

var hunting_player = false
var move_direction: Vector3
var wander_time: float

func randomize_wander():
	move_direction = Vector3(randf_range(-1,1), 0, randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)


func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	
func _physics_process(delta: float) -> void:
	var distance_between = (player.global_position - global_position).length()
	if distance_between < 30:
		hunting_player = true
	if player.playerSafe:
		hunting_player = false
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	if hunting_player:
		agent_shark.target_position = player.global_position
		var direction = agent_shark.get_next_path_position() - position
		velocity = direction.normalized() * shark_move_speed
	else:
		velocity = move_direction * shark_move_speed
	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		jumpscare_image.visible = true
