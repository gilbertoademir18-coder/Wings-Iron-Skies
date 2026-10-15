class_name InputSetup
extends RefCounted

## Registra as ações de input via código (teclado + gamepad XInput).
## Mantém os controles do beta original: setas para mover, A para atirar, ENTER para começar.

const DEADZONE := 0.25


static func setup() -> void:
	_add("move_left", [KEY_LEFT], [JOY_BUTTON_DPAD_LEFT], JOY_AXIS_LEFT_X, -1.0)
	_add("move_right", [KEY_RIGHT], [JOY_BUTTON_DPAD_RIGHT], JOY_AXIS_LEFT_X, 1.0)
	_add("move_up", [KEY_UP], [JOY_BUTTON_DPAD_UP], JOY_AXIS_LEFT_Y, -1.0)
	_add("move_down", [KEY_DOWN], [JOY_BUTTON_DPAD_DOWN], JOY_AXIS_LEFT_Y, 1.0)
	_add("shoot", [KEY_A, KEY_Z, KEY_SPACE], [JOY_BUTTON_A, JOY_BUTTON_X])
	_add("start", [KEY_ENTER, KEY_KP_ENTER], [JOY_BUTTON_START])


static func _add(action: StringName, keys: Array, buttons: Array, axis: int = -1, axis_value: float = 0.0) -> void:
	if InputMap.has_action(action):
		return
	InputMap.add_action(action, DEADZONE)
	for key in keys:
		var key_event := InputEventKey.new()
		key_event.physical_keycode = key
		InputMap.action_add_event(action, key_event)
	for button in buttons:
		var button_event := InputEventJoypadButton.new()
		button_event.button_index = button
		InputMap.action_add_event(action, button_event)
	if axis >= 0:
		var motion_event := InputEventJoypadMotion.new()
		motion_event.axis = axis
		motion_event.axis_value = axis_value
		InputMap.action_add_event(action, motion_event)
