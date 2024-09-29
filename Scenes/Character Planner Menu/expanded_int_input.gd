@tool
extends "res://Scenes/Character Planner Menu/int_input_cell.gd"

# Used for typing only
const IsAscended = preload("res://Scenes/Character Planner Menu/is_ascended.gd")

@export var Ascended: bool = false: set = _set_ascended
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
	# Validation occurs in that IsAscended node
	is_ascended_btn.Ascended = to

func _get_ascended():
	return is_ascended_btn.Ascended

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
