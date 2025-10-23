@tool
extends Node3D

@export var level_float = 0.5
var start_oxygen = false
var time_passed = 0.0

var paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%needle.rotation_degrees.y = lerp(400, 140, level_float)

func _physics_process(delta: float) -> void:
	if start_oxygen:
		time_passed += delta
		if time_passed >= 1.0:
			if not paused:
				level_float -= .005
			if level_float < 0.0:
				level_float = 0.0
			time_passed = 0.0
