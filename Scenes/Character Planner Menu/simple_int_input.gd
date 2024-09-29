@tool
extends "res://Scenes/Character Planner Menu/int_input_cell.gd"

@export var add_by: int = 1: set = _set_add_by
@export var sub_by: int = 1: set = _set_sub_by

@onready var int_input_add: IntInputBtn = $IntInputAdd
@onready var int_input_sub: IntInputBtn = $IntInputSub

# ====================================================== #
#                   SETTERS & GETTERS                    #
# ====================================================== #
func _set_add_by(to: int): 
	add_by = to
	int_input_add.operation_amount = to

func _set_sub_by(to: int): 
	sub_by = to
	int_input_sub.operation_amount = to

# ====================================================== #
#                       OVERRIDES                        #
# ====================================================== #
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_SORT_CHILDREN:
			# Ensures the add and subtract Buttons have the same width
			var add_sub_btn_size = max(int_input_add.get_minimum_size().x, int_input_sub.get_minimum_size().x)
			int_input_add.custom_minimum_size.x = add_sub_btn_size
			int_input_sub.custom_minimum_size.x = add_sub_btn_size

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
