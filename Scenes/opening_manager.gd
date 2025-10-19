extends Node3D

var elapsed = 0.0
var dur1 = 5.0
var dur2 = 10.0
var transition = false
var done = false

@export var skip = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if skip == false:
		%cam1.make_current()
		%AnimationPlayer.current_animation = "crash"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if skip == false:
		elapsed += delta
	if elapsed > dur1 and transition == false:
		%cam2.make_current()
		transition = true
	if elapsed > dur2 and done == false:
		%Player/Pivot/Camera3D.make_current()
		%uncrashed_plane.hide()
		done = true
