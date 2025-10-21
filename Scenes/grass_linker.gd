extends Node

@onready var player = %Player

func _ready():
	for grass in get_tree().get_nodes_in_group("grass"):
		grass.body_entered.connect(player._on_grass_body_entered)
		grass.body_exited.connect(player._on_grass_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
