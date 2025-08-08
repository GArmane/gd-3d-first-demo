extends Node3D


@export var mob: PackedScene = null


signal mob_spawned(mob: Mob)


func _on_spawn_timer_timeout() -> void:
	var new_mob = mob.instantiate()
	add_child(new_mob)
	new_mob.global_position = %SpawnPoint.global_position
	mob_spawned.emit(new_mob)
