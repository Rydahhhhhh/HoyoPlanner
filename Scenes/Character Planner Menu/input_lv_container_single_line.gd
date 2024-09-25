@tool
extends HBoxContainer

@onready var input_lv: LineEdit = $"InputLv"
@onready var input_lv_add: Button = $"InputLv Add"
@onready var input_lv_sub: Button = $"InputLv Sub"
@onready var input_lv_max: Button = $"InputLv Max"

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_SORT_CHILDREN:
			# Ensures the +1 and -1 Buttons have the same width
			var add_sub_btn_size = max(input_lv_add.get_minimum_size().x, input_lv_sub.get_minimum_size().x)
			input_lv_add.custom_minimum_size.x = add_sub_btn_size
			input_lv_sub.custom_minimum_size.x = add_sub_btn_size

# ====================================================== #
#                     BUTTON PRESSES                     #
# ====================================================== #
func add_pressed(): input_lv.lv += 1
func sub_pressed(): input_lv.lv -= 1
func max_pressed(): input_lv.lv = input_lv.max_lv

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
