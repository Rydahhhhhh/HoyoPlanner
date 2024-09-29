@tool
extends LineEdit

signal val_changed(to: int)
signal min_val_changed(to: int)
signal max_val_changed(to: int)

# See setter for the reason val ins't typed
@export var val = 1: set = set_val
@export var min_val: int = 1: set = set_min_val
@export var max_val: int = 1: set = set_max_val
var queued_val = null

func _ready() -> void:
	text = str(val)
	alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	# 'val = val' triggers the setter and will validate it's current value
	var update_val = func(signal_param): val = val
	min_val_changed.connect(update_val)
	max_val_changed.connect(update_val)
	
	text_changed.connect(text_input_changed)
	focus_exited.connect(_on_focus_exited)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		release_focus()

# ====================================================== #
#                    SETTER & GETTERS                    #
# ====================================================== #
func set_val(new_val):
	# Godot doesn't let you set typed variables to null
	# I want setting to null to have the empty text 
	# it lets you have no text inside the text box while you're typing
	
	# Only updates the internal val once you're done typing
	if has_focus():
		if new_val is int:
			if new_val > max_val:
				new_val = max_val
			
			text = str(new_val)
		else:
			assert(new_val == null)
			new_val = min_val
			text = ""
		
		queued_val = new_val
	else:
		assert(new_val is int)
		var x = get_signal_connection_list("val_changed")
		# Ensures new_val is within the range
		if new_val < min_val:
			new_val = min_val
		elif new_val > max_val:
			new_val = max_val
		text = str(new_val)
		
		val = new_val
		val_changed.emit(val)
	
	# Setting text on a LineEdit makes the caret_column = 0
	caret_column = len(text)
	return

func set_min_val(new_min_val):
	if min_val != new_min_val and new_min_val <= max_val:
		min_val = new_min_val
		min_val_changed.emit(new_min_val)

func set_max_val(new_max_val):
	if max_val != new_max_val and new_max_val >= min_val:
		max_val = new_max_val
		max_val_changed.emit(new_max_val)

# ====================================================== #
#                   SIGNAL CONNECTIONS                   #
# ====================================================== #
func text_input_changed(new_text: String):
	var new_val_str := RegEx.create_from_string(r"\D+").sub(new_text, "", true)
	if new_val_str.is_empty():
		val = null
	else:
		assert(new_val_str.is_valid_int())
		val = new_val_str as int
	return

func _on_focus_exited() -> void:
	if queued_val != null:
		# GdScript doesn't allow typed variables to be null
		assert(queued_val is int)
		val = queued_val
	queued_val = null

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
