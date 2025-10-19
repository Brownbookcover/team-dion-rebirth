extends AudioStreamPlayer3D

var elapsed = 0.0
var trigger = 2.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed += delta
	if elapsed > trigger:
		trigger =  randf_range(2.0, 10.0)
		elapsed = 0.0
		play()
		print(play)
