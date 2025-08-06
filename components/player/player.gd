class_name Player extends CharacterBody3D


@export_range(0.0, 1.0, 0.05) var camera_sensibility: float = 0.3


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * camera_sensibility
		%Camera3D.rotation_degrees.x -= event.relative.y * camera_sensibility
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -60.0, 60.0)
