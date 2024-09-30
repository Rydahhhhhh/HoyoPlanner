@tool
extends Container

signal val_changed(to: int)

# Used for typing only
const IntInput = preload("res://Scenes/Character Planner Menu/int_input.gd")
const IntInputBtn = preload("res://Scenes/Character Planner Menu/int_input_btn.gd")
const IsAscended = preload("res://Scenes/Character Planner Menu/is_ascended.gd")

@onready var int_input: IntInput = %IntInput
@export var val: int: set = _set_val, get = _get_val
@export var min: int = 1: set = _set_min, get = _get_min
@export var max: int = 1: set = _set_max, get = _get_max

func _ready() -> void:
	assert(int_input != null)

func get_data(data: Dictionary = {}) -> Dictionary:
	assert("val" not in data)
	data["val"] = int_input.val
	return data

# ====================================================== #
#                   SETTERS & GETTERS                    #
# ====================================================== #
func _set_val(to: int):
	if not is_node_ready():
		await ready
	int_input.val = to

func _get_val():
	if not is_node_ready():
		await ready
	return int_input.val

func _set_min(to: int):
	if not is_node_ready():
		await ready
	int_input.min_val = to

func _get_min():
	if not is_node_ready():
		await ready
	return int_input.min_val

func _set_max(to: int):
	if not is_node_ready():
		await ready
	int_input.max_val = to

func _get_max():
	if not is_node_ready():
		await ready
	return int_input.max_val

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
