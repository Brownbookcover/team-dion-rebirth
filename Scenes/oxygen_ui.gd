extends Control

var oxygen_level = 100
var time_passed = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	time_passed += delta
	if time_passed >= 1.0:
		oxygen_level -= 1
		time_passed = 0.0
	$RichTextLabel.text = "Oxygen " + str(oxygen_level)
