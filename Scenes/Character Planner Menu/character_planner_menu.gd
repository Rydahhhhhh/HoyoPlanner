@tool
extends EasyGrid

const SR_LABEL_COLUMN = preload("res://Scenes/Character Planner Menu/sr_label_column.tscn")
const INPUT_COLUMN = preload("res://Scenes/Character Planner Menu/Input Column.tscn")

func _ready() -> void:
	for child in get_children():
		child.queue_free()
	add_star_rail_columns()

# ====================================================== #
#                        COLUMNS                         #
# ====================================================== #
func add_star_rail_columns():
	
	add_grid_column(SR_LABEL_COLUMN.instantiate())
	add_star_rail_input_column()
	return

func add_star_rail_input_column():
	var column = INPUT_COLUMN.instantiate()
	column.add_input_lv_container("Expanded", "Character", 80)
	column.add_input_lv_container("Simple", "BasicAtk", 6)
	column.add_input_lv_container("Simple", "Skill", 12)
	column.add_input_lv_container("Simple", "Ultimate", 12)
	column.add_input_lv_container("Simple", "Talent", 12)
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

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
