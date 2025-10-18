@tool
extends MeshInstance3D

var elapsed = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed += delta
	basis.y.z = sin(elapsed) * 0.1
	basis.x.y = sin(elapsed) * 0.1
	basis.z.x = sin(elapsed) * 0.1
