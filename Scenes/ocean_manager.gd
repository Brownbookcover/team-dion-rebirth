@tool
extends Node

@export var depth_range = 60
@export var helmet_width = 0.5
@export var helmet_offset = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%OceanEnv.helmet_width = helmet_width


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%OceanEnv.depth = clamp(%Player.position.y, -depth_range, depth_range) / depth_range
	%OceanEnv.helmet_position = %Player.position + helmet_offset
	%OceanEnv.helmet_width = helmet_width
	if %Player.position.y > 0:
		%oceanDust.hide()
	else:
		%oceanDust.show()
	pass
