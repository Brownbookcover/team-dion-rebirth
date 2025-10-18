extends StaticBody3D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var my_random_number = rng.randi_range(8, 9)
	##if my_random_number == 8:
	#	$TextureRect.visible = true
	#	await get_tree().create_timer(3).timeout
	#	$TextureRect.visible = false
	pass
