@tool
extends CheckButton

# Used for typing only
const IntInput = preload("res://Scenes/Character Planner Menu/int_input.gd")
const IntInputBtn = preload("res://Scenes/Character Planner Menu/int_input_btn.gd")

@export var int_input: IntInput
@export var int_input_btn: IntInputBtn
@export var Ascended: bool = false: set = _set_ascended, get = _get_ascended

func _ready() -> void:
	# Using lambda functions due to the signals having parameters
	int_input.val_changed.connect(func(x): input_val_changed())
	int_input.max_val_changed.connect(func(x): input_val_changed())
	int_input.min_val_changed.connect(func(x): input_val_changed())
	
	# Assume acension when you cycle 
	# Possibly not needed, I'll keep it for now
	int_input_btn.cycled.connect(func(x): button_pressed = true)
	return

func input_val_changed():
	match int_input.val:
		int_input.min_val:
			button_pressed = false
			disabled = true
		int_input.max_val:
			button_pressed = true
			disabled = true
		_:
			disabled = false
	return
# ====================================================== #
#                   SETTERS & GETTERS                    #
# ====================================================== #
func _set_ascended(to: bool):
	if disabled:
		return
	button_pressed = to
	Ascended = button_pressed

func _get_ascended():
	return button_pressed

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
