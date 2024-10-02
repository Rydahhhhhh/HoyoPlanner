@tool
class_name IntInputEdit extends LineEdit

signal value_changed(to: int) ## Emitted only when the [member value] [b]actually[/b] changes. See [method _set_value]
signal min_value_changed(to: int) ## Emitted when the min_value is changed. 
signal max_value_changed(to: int) ## Emitted when the max_value is changed. 


# See setter for the reason value ins't typed
@export var value = 1: set = set_value
@export var min_value: int = 1: set = set_min_value
@export var max_value: int = 1: set = set_max_value

var queued_value = null
var validators: Array[Callable] = []

func _ready() -> void:
	text = str(value)
	alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	# 'value = value' triggers the setter and will valueidate it's current value
	var update_value = func(signal_param): value = value
	min_value_changed.connect(update_value)
	max_value_changed.connect(update_value)
	
	text_changed.connect(text_input_changed)
	focus_exited.connect(_on_focus_exited)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		release_focus()

func _validate_property(property: Dictionary) -> void:
	match property.name:
		"value", "min_value", "max_value":
			property.usage = PROPERTY_USAGE_EDITOR

# ====================================================== #
#                    SETTER & GETTERS                    #
# ====================================================== #
func set_value(new_value):
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
		
		queued_value = new_value
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

func set_min_value(new_min_value):
	if min_value != new_min_value and new_min_value <= max_value:
		min_value = new_min_value
		min_value_changed.emit(new_min_value)

func set_max_value(new_max_value):
	if max_value != new_max_value and new_max_value >= min_value:
		max_value = new_max_value
		max_value_changed.emit(new_max_value)

# ====================================================== #
#                   SIGNAL CONNECTIONS                   #
# ====================================================== #
func text_input_changed(new_text: String):
	var new_value_str := RegEx.create_from_string(r"\D+").sub(new_text, "", true)
	if new_value_str.is_empty():
		value = null
	else:
		assert(new_value_str.is_valid_int())
		value = new_value_str as int
	return

func _on_focus_exited() -> void:
	if queued_value != null:
		# GdScript doesn't allow typed variables to be null
		assert(queued_value is int)
		value = queued_value
	queued_value = null

# ====================================================== #
#                        METHODS                         #
# ====================================================== #
func add_validator(validator_fn: Callable, ):
	validators.append(validator_fn)
	return


# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
