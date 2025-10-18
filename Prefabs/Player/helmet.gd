# child_smoothed_lag.gd attached to the child Node3D

extends Node3D

# --- Lag Timing Controls ---
@export_range(0.01, 1.0, 0.01) var lag_time: float = 0.15   # The delay in seconds (e.g., 0.15 seconds)
@export var history_capacity: int = 5                       # Max number of rotations to store
@export var smoothing_speed: float = 15.0                    # How fast the child smoothly catches the delayed position

# --- Internal Variables ---
var rotation_history: Array[Basis] = []
var parent_node: Node3D 

func _ready():
	if not get_parent() is Node3D:
		push_error("Parent node must be a Node3D.")
		set_process(false)
		return
		
	parent_node = get_parent()
	# Pre-fill history
	var initial_rotation = parent_node.global_transform.basis
	for i in history_capacity:
		rotation_history.append(initial_rotation)

func _process(delta: float):
	# --- 1. Store the current rotation of the parent ---
	rotation_history.push_front(parent_node.global_transform.basis)
	if rotation_history.size() > history_capacity:
		rotation_history.pop_back()

	# --- 2. Calculate the Index for the Delayed Rotation ---
	# Calculate how many frames back we need to look
	var delay_frames = int(lag_time / delta)
	var delayed_index = min(delay_frames, rotation_history.size() - 1)
	
	# --- 3. Get the Target (Delayed) Rotation ---
	var delayed_target_rotation: Basis
	if delayed_index >= 0:
		delayed_target_rotation = rotation_history[delayed_index]
	else:
		# Fallback if history is somehow empty
		return

	# --- 4. Smoothly Interpolate to the Delayed Target ---
	var current_rotation: Basis = global_transform.basis
	
	# Use slerp to blend the child's current rotation towards the target rotation from the past.
	var amount = smoothing_speed * delta
	var new_rotation_basis: Basis = current_rotation.slerp(delayed_target_rotation, amount)
	
	# Apply the new rotation
	global_transform.basis = new_rotation_basis
