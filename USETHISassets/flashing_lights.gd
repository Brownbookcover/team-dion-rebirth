@tool
extends Node3D

var elapsed = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed += delta
	if elapsed > 1:
		elapsed = 0
		if visible == true:
			hide()
		else:
			show()
