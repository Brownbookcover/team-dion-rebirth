extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%breathsound1.stream_paused = true
	%breathsound2.stream_paused = true
	%breathsound3.stream_paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if %OxygenUi.oxygen_level > 60:
		%breathsound1.stream_paused = false
		%breathsound2.stream_paused = true
		%breathsound3.stream_paused = true
	elif %OxygenUi.oxygen_level > 30:
		%breathsound1.stream_paused = true
		%breathsound2.stream_paused = false
		%breathsound3.stream_paused = true
	elif %OxygenUi.oxygen_level < 30:
		%breathsound1.stream_paused = true
		%breathsound2.stream_paused = true
		%breathsound3.stream_paused = false
