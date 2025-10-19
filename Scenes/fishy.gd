extends Node3D

var index = 0
@onready var points = [$Point1.global_position, $Point2.global_position, $Point3.global_position]
@export var rotation_speed: float = 7.0 
var target_rotation: Basis 

func _ready() -> void:
	target_rotation = $School.global_transform.basis

func _physics_process(delta: float) -> void:
	var school_node = $School
	var target_position = points[index]
	var distance_to_target = (target_position - school_node.global_position).length()
	
	if distance_to_target < 0.5:
		index = (index + 1) % 3
		target_position = points[index]
	var direction = target_position - school_node.global_position
	if direction.length_squared() > 0.001:
		var temp_transform = school_node.global_transform.looking_at(
			school_node.global_position + direction.normalized(), 
			Vector3.UP, 
			false
		)
		target_rotation = temp_transform.basis

	var current_basis = school_node.global_transform.basis
	var smoothed_basis = current_basis.slerp(target_rotation, delta * rotation_speed)
	school_node.global_transform.basis = smoothed_basis
	school_node.global_position += direction.normalized() * delta * 5
