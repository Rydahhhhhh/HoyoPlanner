@tool
extends "res://Scenes/Character Planner Menu/int_input_cell.gd"


@export var Ascended: bool = false: set = _set_ascended, get = _get_ascended
@onready var is_ascended_btn: IsAscended = %IsAscended

# ====================================================== #
#                       FUNCTIONS                        #
# ====================================================== #
func get_data(data: Dictionary = {}) -> Dictionary:
	super(data)
	data["Ascended"] = Ascended
	return data

# ====================================================== #
#                   SETTERS & GETTERS                    #
# ====================================================== #
func _set_ascended(to: bool):
	if not is_node_ready():
		await ready
	# Validation occurs in that IsAscended node
	is_ascended_btn.Ascended = to

func _get_ascended():
	if not is_node_ready():
		await ready
	return is_ascended_btn.Ascended

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
