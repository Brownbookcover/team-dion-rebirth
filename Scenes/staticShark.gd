extends Node3D

@onready var move_shark = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if move_shark:
		position += -global_transform.basis.z * 150 * delta


func _on_jumpscare_trigger_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("Blag")
		move_shark = true
