extends Area3D


@export_range(0.0, 100.0, 0.5) var speed := 55.0
@export_range(0.0, 400.0, 0.5) var max_range := 200.0


var _distance_travelled := 0.0


func _physics_process(delta: float) -> void:
	position += transform.basis.z * speed * delta
	_distance_travelled += speed * delta
	if _distance_travelled >= max_range:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()
