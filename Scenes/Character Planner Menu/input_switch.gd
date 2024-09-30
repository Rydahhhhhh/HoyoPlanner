@tool
class_name InputSwitch extends CheckButton

signal value_changed(to)

var value: bool: set = _set_value, get = _get_value

func _ready() -> void:
	var validate_self = func(x=null): value = value
	if owner and owner.has_signal("value_changed"):
		owner.value_changed.connect(validate_self)

func _toggled(toggled_on: bool) -> void:
	value = toggled_on

func _get_value():
	return button_pressed

func _set_value(to: bool):
	if not is_node_ready():
		await ready
	
	if owner and "switch_validator" in owner and owner.switch_validator != null:
		assert(owner.switch_validator is Callable)
		button_pressed = owner.switch_validator.call(to)
	else:
		button_pressed = to
	if owner and "switch_disable_condition" in owner and owner.switch_disable_condition != null:
		assert(owner.switch_disable_condition is Callable)
		disabled = owner.switch_disable_condition.call(to)
	else:
		disabled = false
	# if the value was actually changed
	if button_pressed == not to:
		value_changed.emit(to)
