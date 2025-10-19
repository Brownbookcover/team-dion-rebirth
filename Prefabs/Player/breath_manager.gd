extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%breathsound1.stream_paused = true
	%breathsound2.stream_paused = true
	%breathsound3.stream_paused = true
	%Gauge.start_oxygen = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# print(%Gauge.start_oxygen, %Gauge.level_float, %breathsound1.stream_paused, %breathsound2.stream_paused, %breathsound3.stream_paused)
	if %Gauge.start_oxygen == true:
		if %Gauge.level_float > 0.6:
			%breathsound1.stream_paused = false
			%breathsound2.stream_paused = true
			%breathsound3.stream_paused = true
		elif %Gauge.level_float > 0.30:
			%breathsound1.stream_paused = true
			%breathsound2.stream_paused = false
			%breathsound3.stream_paused = true
		elif %Gauge.level_float < 0.16:
			%breathsound1.stream_paused = true
			%breathsound2.stream_paused = true
			%breathsound3.stream_paused = false
	else:
		%breathsound1.stream_paused = true
		%breathsound2.stream_paused = true
		%breathsound3.stream_paused = true
