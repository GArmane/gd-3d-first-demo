class_name Mob extends RigidBody3D


@onready var player: Player = get_node("/root/World/Player")
var _speed: int = randi_range(2, 5)
var _health:int = 3


signal died


func take_damage() -> void:
	if _health <= 0: return

	_health -= 1
	%Model.hurt()
	%DamageSound.play()
	if _health <= 0:
		set_physics_process(false)
		gravity_scale = 1.0
		var opposite_dir_to_player := global_position.direction_to(player.global_position) * -1.0
		var random_upward_force := Vector3.UP * randf_range(1.0, 5.0)
		apply_central_impulse(opposite_dir_to_player * 10.0 + random_upward_force)
		%DeathSound.play()
		%DeathTimer.start()
		died.emit()


func _physics_process(_delta: float) -> void:
	var direction := global_position.direction_to(player.global_position)
	direction.y = 0.0
	linear_velocity = direction * _speed
	%Model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI


func _on_death_timer_timeout() -> void:
	queue_free()
