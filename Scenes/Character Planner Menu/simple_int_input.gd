@tool
extends IntInputCell

@onready var int_input_add: IntInputBtn = $IntInputAdd
@onready var int_input_sub: IntInputBtn = $IntInputSub
@onready var int_input_max: IntInputBtn = $IntInputMax

@export var add_by: int = 1: set = _set_add_by, get = _get_add_by
@export var sub_by: int = 1: set = _set_sub_by, get = _get_sub_by

# ====================================================== #
#                   SETTERS & GETTERS                    #
# ====================================================== #
func _set_add_by(to: int):
	if not is_node_ready():
		await ready
	int_input_add.operation_amount = to

func _get_add_by(): 
	if not is_node_ready():
		await ready
	return int_input_add.operation_amount

func _set_sub_by(to: int): 
	if not is_node_ready():
		await ready
	int_input_sub.operation_amount = to

func _get_sub_by(): 
	if not is_node_ready():
		await ready
	return int_input_sub.operation_amount
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
