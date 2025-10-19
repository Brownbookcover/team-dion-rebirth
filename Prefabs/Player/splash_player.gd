extends AudioStreamPlayer3D


var triggered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent_node_3d().position.y < 0 and triggered == false:
		triggered = true
		play()
