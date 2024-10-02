@tool
class_name IntInputEdit 
extends LineEdit
## A LineEdit node that only accepts [int]

signal value_changed(to: int) ## Emitted only when the [member value] [b]actually[/b] changes. See [method _set_value]
signal min_value_changed(to: int) ## Emitted when the min_value is changed. 
signal max_value_changed(to: int) ## Emitted when the max_value is changed. 

const MIN_FLAG = 1 << 0 ## BitFlag that tells [method clamp_with_flag] to clamp [member value] to the minimum
const MAX_FLAG = 1 << 1 ## BitFlag that tells [method clamp_with_flag] to clamp [member value] to the maximum

## Flags that determine how [member value] should be clamped. 
@export_flags("MIN", "MAX") 
var clamp_behavior: int = 0: set = _set_clamp_behavior

## Only shown in editor if [member clamp_behavior] has [constant MIN_FLAG]
@export var min_value: int = 1: set = _set_min_value
## Only shown in editor if [member clamp_behavior] has [constant MAX_FLAG]
@export var max_value: int = 1: set = _set_max_value

## The [int] value the node represents. [b]Won't always be the same as what is displayed on the screen. [/b][br][br]
## [b]Note:[/b] Due to the inability of setting typed variables to null this variable isn't typed to [int]
var value = 1: set = _set_value

var _validators: Array[Callable] = []
var _queued_value = null

# ====================================================== #
#                VIRTUAL METHOD OVERRIDES                #
# ====================================================== #
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
	if property.name == "min_value" and not clamp_behavior & MIN_FLAG:
		property.usage = PROPERTY_USAGE_NONE
	if property.name == "max_value" and not clamp_behavior & MAX_FLAG:
		property.usage = PROPERTY_USAGE_NONE

# ====================================================== #
#                     PRIVATE METHODS                    #
# ====================================================== #
## Clamps a [param val] within the [member min_value] & [member max_value] properties 
## if [param flags] includes the [constant MIN_FLAG] & [constant MAX_FLAG] respectively
func _clamp_with_flag(val: int, flags: int) -> int:
	if MIN_FLAG & flags:
		val = max(val, min_value)
	if MAX_FLAG & flags:
		val = min(val, max_value)
	
	return val

# =========================== #
#      SETTER & GETTERS       #
# =========================== #
## Validates and sets [member value]
## if called while in focus, [member value] won't be updated until focus is lost. Required to allow the [member text] to be empty while typing.
func _set_value(new_value):
	# Godot doesn't let you set typed variables to null
	# I want setting to null to have the empty text 
	# as it lets you have no text inside the text box while you're typing
	
	# Only updates the internal value once you're done typing
	if has_focus():
		if new_value is int:
			# Prevent exceeding maximum value
			new_value = _clamp_with_flag(new_value, clamp_behavior & MAX_FLAG)
			text = str(new_value)
		else:
			assert(new_value == null)
			new_value = min_value
			text = ""
		_queued_value = new_value
	else:
		assert(new_value is int)
		
		new_value = _clamp_with_flag(new_value, clamp_behavior & MIN_FLAG | MAX_FLAG)
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

func _set_clamp_behavior(to: int):
	# Is there really not shorhand way to do this ?
	clamp_behavior = to
	notify_property_list_changed()

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
		assert(_queued_value is int)
		value = _queued_value
	_queued_value = null

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
