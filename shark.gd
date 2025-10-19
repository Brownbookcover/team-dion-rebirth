extends CharacterBody3D

@export var shark_move_speed := 5
@export var agent_shark: NavigationAgent3D
@export var jumpscare_image: Sprite2D
var player: CharacterBody3D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(delta: float) -> void:
	agent_shark.target_position = player.global_position
	var direction = agent_shark.get_next_path_position() - position
	velocity = direction.normalized() * shark_move_speed
	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		jumpscare_image.visible = true
