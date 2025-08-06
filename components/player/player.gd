class_name Player extends CharacterBody3D


@export_range(0.0, 1.0, 0.05) var camera_sensibility: float = 0.3
@export_range(0.0, 10.0, 0.5) var movement_speed: float = 5.0


func _physics_process(delta: float) -> void:
	var input_direction_2d := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var input_direction_3d := Vector3(input_direction_2d.x, 0.0, input_direction_2d.y)
	var direction := transform.basis * input_direction_3d
	velocity.x = direction.x * movement_speed
	velocity.z = direction.z * movement_speed
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * camera_sensibility
		%Camera3D.rotation_degrees.x -= event.relative.y * camera_sensibility
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -60.0, 60.0)
