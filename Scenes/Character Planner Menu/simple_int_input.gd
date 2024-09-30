@tool
extends IntInputCell

@onready var int_input_add: IntInputBtn = $IntInputAdd
@onready var int_input_sub: IntInputBtn = $IntInputSub
@onready var int_input_max: IntInputBtn = $IntInputMax

func _ready() -> void:
	super()
	delegate_property(int_input_add, "operation_amount", "add_by")
	delegate_property(int_input_sub, "operation_amount", "sub_by")

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
