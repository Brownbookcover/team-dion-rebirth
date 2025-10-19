class_name Pickup
extends Area3D

@export var pickup_name: String

@export var mesh: MeshInstance3D

func hover():
	mesh.mesh.surface_get_material(0).next_pass.albedo_color = Color.WHITE


func unhover():
	mesh.mesh.surface_get_material(0).next_pass.albedo_color = Color.YELLOW
