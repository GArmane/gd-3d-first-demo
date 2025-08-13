extends Node3D


const _MOB_SPAWN_VFX = preload("res://components/mob/smoke_puff/smoke_puff.tscn")
var _game_score: int = 0


func _ready() -> void:
	_toggle_mouse_mode()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEvent and event.is_action_pressed("ui_cancel"):
		_toggle_mouse_mode()


func _toggle_mouse_mode() -> void:
	var mode = Input.MOUSE_MODE_VISIBLE \
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED \
		else Input.MOUSE_MODE_CAPTURED
	Input.set_mouse_mode(mode)


func _increase_score() -> void:
	_game_score += 1
	%HUD.set_score(_game_score)


func _spawn_smoke_vfx(mob: Mob) -> void:
	var vfx = _MOB_SPAWN_VFX.instantiate()
	add_child(vfx)
	vfx.global_position = mob.global_position


func _on_mob_spawner_3d_mob_spawned(mob: Mob) -> void:
	mob.died.connect(func ():
		_increase_score()
		_spawn_smoke_vfx(mob)
	)
	_spawn_smoke_vfx(mob)


func _on_kill_plane_body_entered(body: Node3D) -> void:
	get_tree().reload_current_scene.call_deferred()
