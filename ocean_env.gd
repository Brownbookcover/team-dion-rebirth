
extends Node3D

var env
var sun
var elapsed = 0
var helmet_position = Vector3.ZERO
var helmet_width = 0.5
@export var depth = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	env = %oceanWorldEnv.environment
	sun = %sun

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed += delta
	# depth = sin(elapsed * 2)
	refresh_water_from_depth()
	set_helmet_hole()
	
func set_helmet_hole():
	var mat = %water_surface_above.get_active_material(0)
	mat.set_shader_parameter("fade_position", helmet_position)
	mat.set_shader_parameter("fade_radius", helmet_width )

func refresh_water_from_depth():
	if depth > 0:
		env.background_color = Color("#ffffff")
		env.glow_strength = 0.002
		env.fog_density = 0.00002
		env.fog_light_color = Color("#888888")# * (abs(cos(depth)) / 2)
		env.background_mode = Environment.BGMode.BG_SKY
		env.adjustment_brightness = 1
		env.fog_light_energy = 0.0
	else:
		env.background_color = Color("070817ff")# * (abs(cos(depth)) / 2)
		env.fog_light_color = Color("0e0f18ff")# * (abs(cos(depth)) / 2)
		env.glow_strength = 2.0
		env.fog_density = 0.0283#* (abs(depth))
		# env.adjustment_brightness = lerp(0.1, 1.0, depth + 1)
		env.fog_light_energy = lerp(0.07, 2.0, depth + 1)
		
		env.background_mode = Environment.BGMode.BG_COLOR
