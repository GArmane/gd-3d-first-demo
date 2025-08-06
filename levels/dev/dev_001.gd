extends Node3D


func _ready() -> void:
	_toggle_mouse_mode()


func _toggle_mouse_mode() -> void:
	var mode = Input.MOUSE_MODE_VISIBLE \
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED \
		else Input.MOUSE_MODE_CAPTURED
	Input.set_mouse_mode(mode)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEvent and event.is_action_pressed("ui_cancel"):
		_toggle_mouse_mode()
