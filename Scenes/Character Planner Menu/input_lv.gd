@tool
extends LineEdit

signal lv_changed(to: int)
signal min_lv_changed(to: int)
signal max_lv_changed(to: int)

var lv: int = 1: set = set_lv
var min_lv: int = 1: set = set_min_lv
var max_lv: int = 1: set = set_max_lv
var queued_lv = null

func _ready() -> void:
	# lv = lv triggers the setter and will validate it's current value
	var update_lv = func(signal_param): lv = lv
	min_lv_changed.connect(update_lv)
	max_lv_changed.connect(update_lv)

# ====================================================== #
#                    SETTER & GETTERS                    #
# ====================================================== #
func set_lv(new_lv):
	# Currently, you aren't able to backspace on a single character 
	# May opt to setting this after focus is removed instead
	if new_lv < min_lv:
		new_lv = min_lv
	elif new_lv > max_lv:
		new_lv = max_lv
	
	text = str(new_lv)
	caret_column = len(text)
	
	lv = text as int
	lv_changed.emit(lv)
	return

func set_min_lv(new_min_lv):
	if min_lv != new_min_lv:
		min_lv = new_min_lv
		min_lv_changed.emit(new_min_lv)

func set_max_lv(new_max_lv):
	if max_lv != new_max_lv:
		max_lv = new_max_lv
		max_lv_changed.emit(new_max_lv)

# ====================================================== #
#                   SIGNAL CONNECTIONS                   #
# ====================================================== #
func text_input_changed(new_text: String):
	var new_lv_str := RegEx.create_from_string(r"\D+").sub(new_text, "", true)
	assert(new_lv_str.is_valid_int() or new_lv_str.is_empty())
	
	text = new_lv_str
	# Only updates the internal lv once you're done typing
	if has_focus():
		queued_lv = min_lv if new_lv_str.is_empty() else new_lv_str as int
	return

func _on_focus_exited() -> void:
	if queued_lv != null:
		# GdScript doesn't allow typed variables to be null
		assert(queued_lv is int)
		lv = queued_lv
	queued_lv = null

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
