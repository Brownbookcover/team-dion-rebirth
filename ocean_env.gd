extends Node3D

var env
var underwater = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	env = %oceanWorldEnv.environment

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		toggle_water()

func toggle_water():
	if underwater:
		env.background_color = Color("#ffffff")
		env.glow_strength = 0.0
		env.fog_density = 0.0
		env.background_mode = Environment.BGMode.BG_SKY
		
		underwater = false
	else:
		env.background_color = Color("#282f85")
		env.glow_strength = 2.0
		env.fog_density = 0.1283
		
		env.background_mode = Environment.BGMode.BG_COLOR
		underwater = true
