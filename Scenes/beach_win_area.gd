extends Area3D

@onready var player = %Player

func _ready():
	body_entered.connect(player._on_beach_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
