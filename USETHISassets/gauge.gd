@tool
extends Node3D

@export var level_float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%needle.rotation_degrees.y = lerp(400, 140, level_float)
