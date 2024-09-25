@tool
extends "res://Scenes/Character Planner Menu/input_column.gd"

func _ready() -> void:
	add_multiline_input_lv_container("Character", 80)
	add_input_lv_container("BasicAtk", 6)
	add_input_lv_container("Skill", 12)
	add_input_lv_container("Ultimate", 12)
	add_input_lv_container("Talent", 12)
	add_spacer(false)
	add_spacer(false)
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_spacer(false)
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_check_box("")
	add_spacer(false)
	add_check_box("")
	add_check_box("")
	add_check_box("")
