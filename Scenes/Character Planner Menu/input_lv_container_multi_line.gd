@tool
extends VBoxContainer

@onready var input_lv: LineEdit = %InputLv
@onready var input_lv_check_btn: CheckButton = %"InputLv Switch"
@onready var input_lv_btn_cycle: Button = %"InputLv Cycle"
@onready var input_lv_btn_max: Button = %"InputLv Max"

# ====================================================== #
#                     BUTTON PRESSES                     #
# ====================================================== #
func add_pressed(): input_lv.lv += 1
func sub_pressed(): input_lv.lv -= 1
func max_pressed(): input_lv.lv = input_lv.max_lv

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
