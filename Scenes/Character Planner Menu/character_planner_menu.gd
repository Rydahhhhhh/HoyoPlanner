@tool
extends EasyGrid

const INPUT_COLUMN = preload("res://Scenes/Character Planner Menu/Input Column.tscn")

func _ready() -> void:
	add_star_rail_input_column()

# ========================================= #
#                  COLUMNS                  #
# ========================================= #
func add_star_rail_input_column():
	var column = INPUT_COLUMN.instantiate()
	column.add_input_lv_container("BasicAtk", 6)
	column.add_input_lv_container("Skill", 12)
	column.add_input_lv_container("Ultimate", 12)
	column.add_input_lv_container("Talent", 12)
	column.add_spacer(false)
	column.add_spacer(false)
	column.add_check_box("")
	column.add_check_box("")
	column.add_check_box("")
	column.add_spacer(false)
	column.add_check_box("")
	column.add_check_box("")
	column.add_check_box("")
	column.add_check_box("")
	column.add_spacer(false)
	column.add_check_box("")
	column.add_check_box("")
	column.add_check_box("")
	add_grid_column(column)
	return
