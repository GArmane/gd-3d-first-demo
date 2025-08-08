class_name Player extends CharacterBody3D


const BULLED_3D = preload("res://components/bullet/bullet_3d.tscn")
const GRAVITY := 9.8

@export_range(1.0, 1.0, 0.05) var camera_sensibility := 0.3
@export_range(1.0, 10.0, 0.5) var movement_speed := 5.0
@export_range(1.0, 10.0, 0.5) var movement_jump_height := 4.0


func _shoot() -> void:
	var bullet = BULLED_3D.instantiate()
	%GunBulletSpawnPoint.add_child(bullet)
	bullet.global_transform = %GunBulletSpawnPoint.global_transform
	
	%GunShotTimer.start()


func _physics_process(delta: float) -> void:
	var input_direction_2d := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var input_direction_3d := Vector3(input_direction_2d.x, 0.0, input_direction_2d.y)
	var direction := transform.basis * input_direction_3d
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = movement_jump_height
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = movement_jump_height / 2

	velocity.x = direction.x * movement_speed
	velocity.z = direction.z * movement_speed
	velocity.y -= GRAVITY * delta

	move_and_slide()

	if Input.is_action_pressed("shoot") and %GunShotTimer.is_stopped():
		_shoot()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * camera_sensibility
		%Camera3D.rotation_degrees.x -= event.relative.y * camera_sensibility
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -60.0, 60.0)
