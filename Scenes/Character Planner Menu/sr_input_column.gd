@tool
extends "res://Scenes/Character Planner Menu/input_column.gd"

func _ready() -> void:
	for child in get_children().duplicate():
		child.queue_free()

	add_input_lv_container("Expanded", "Character", 80)
	add_input_lv_container("Simple", "BasicAtk", 6)
	add_input_lv_container("Simple", "Skill", 12)
	add_input_lv_container("Simple", "Ultimate", 12)
	add_input_lv_container("Simple", "Talent", 12)
	
	add_spacer(false)
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_check_box("")
	return

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
