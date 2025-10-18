extends Node

@export var depth_range = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%OceanEnv.depth = clamp(%Player.position.y, -depth_range, depth_range) / depth_range
	if %Player.position.y > 0:
		%oceanDust.hide()
	else:
		%oceanDust.show()
	pass
