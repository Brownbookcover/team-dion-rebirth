extends State
class_name StateChase

@export var shark: CharacterBody3D
@export var move_speed := 5
@export var agent_shark: NavigationAgent3D
var player: CharacterBody3D

func Enter():
	player = get_tree().get_first_node_in_group("player")
	
func Physics_Update(delta: float):
	agent_shark.target_position = player.global_position
	var direction = agent_shark.get_next_path_position() - shark.global_position
	shark.velocity = direction.normalized() * move_speed
	shark.move_and_slide()
