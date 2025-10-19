class_name Pickup
extends Area3D

@export var pickup_name: String

@export var mesh: MeshInstance3D
@export var mesh1: MeshInstance3D
@export var mesh2: MeshInstance3D

func hover():
	if pickup_name == "helmet":
		mesh.mesh.surface_get_material(0).next_pass.albedo_color = Color.WHITE
	if pickup_name == "canister":
		mesh1.mesh.surface_get_material(0).next_pass.albedo_color = Color.WHITE
		mesh1.mesh.surface_get_material(1).next_pass.albedo_color = Color.WHITE
		mesh2.mesh.surface_get_material(0).next_pass.albedo_color = Color.WHITE


func unhover():
	if pickup_name == "helmet":
		mesh.mesh.surface_get_material(0).next_pass.albedo_color = Color.YELLOW
	if pickup_name == "canister":
		mesh1.mesh.surface_get_material(0).next_pass.albedo_color = Color.YELLOW
		mesh1.mesh.surface_get_material(1).next_pass.albedo_color = Color.YELLOW
		mesh2.mesh.surface_get_material(0).next_pass.albedo_color = Color.YELLOW
