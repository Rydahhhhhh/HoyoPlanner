@tool
class_name IntInputEdit 
extends LineEdit
## A LineEdit node that only accepts [int]

signal value_changed(to: int) ## Emitted only when the [member value] [b]actually[/b] changes. See [method _set_value]
signal min_value_changed(to: int) ## Emitted when the min_value is changed. 
signal max_value_changed(to: int) ## Emitted when the max_value is changed. 


@export var min_value: int = 1: set = _set_min_value
@export var max_value: int = 1: set = _set_max_value

## The [int] value the node represents. [b]Won't always be the same as what is displayed on the screen. [/b][br][br]
## [b]Note:[/b] Due to the inability of setting typed variables to null this variable isn't typed to [int]
var value = 1: set = _set_value

var _validators: Array[Callable] = []
var _queued_value = null
func _ready() -> void:
	text = str(value)
	
	# 'value = value' calls the setter and validates it's current value
	var update_value = func(signal_param): value = value
	min_value_changed.connect(update_value)
	max_value_changed.connect(update_value)
	
	text_changed.connect(_text_input_changed)
	focus_exited.connect(_on_focus_exited)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		release_focus()
#
func _validate_property(property: Dictionary) -> void:
	match property.name:
		"value", "min_value", "max_value":
			property.usage = PROPERTY_USAGE_EDITOR

# ====================================================== #
#                     PRIVATE METHODS                    #
# ====================================================== #
# =========================== #
#      SETTER & GETTERS       #
# =========================== #
func _set_value(new_value):
	# Godot doesn't let you set typed variables to null
	# I want setting to null to have the empty text 
	# as it lets you have no text inside the text box while you're typing
	
	# Only updates the internal value once you're done typing
	if has_focus():
		if new_value is int:
			# Even when you're typing it'll prevent you from going above the maximum
			if new_value > max_value:
				new_value = max_value
			
			text = str(new_value)
		else:
			assert(new_value == null)
			new_value = min_value
			text = ""
		_queued_value = new_value
	else:
		assert(new_value is int)
		
		# Ensures new_value is within the range
		if new_value < min_value:
			new_value = min_value
		elif new_value > max_value:
			new_value = max_value
		text = str(new_value)
		value = new_value
		value_changed.emit(value)
	
	# Setting text on a LineEdit makes the caret_column = 0
	caret_column = len(text)
	return

func _set_min_value(new_min_value):
	if min_value != new_min_value and new_min_value <= max_value:
		min_value = new_min_value
		min_value_changed.emit(new_min_value)

func _set_max_value(new_max_value):
	if max_value != new_max_value and new_max_value >= min_value:
		max_value = new_max_value
		max_value_changed.emit(new_max_value)

# =========================== #
#     SIGNAL CONNECTIONS      #
# =========================== #
func _text_input_changed(new_text: String):
	var new_value_str := RegEx.create_from_string(r"\D+").sub(new_text, "", true)
	if new_value_str.is_empty():
		value = null
	else:
		assert(new_value_str.is_valid_int())
		value = new_value_str as int
	return

func _on_focus_exited() -> void:
	if _queued_value != null:
		# GdScript doesn't allow typed variables to be null
func add_validator(validator_fn: Callable, ):
	validators.append(validator_fn)
	return

		assert(_queued_value is int)
		value = _queued_value
	_queued_value = null

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
