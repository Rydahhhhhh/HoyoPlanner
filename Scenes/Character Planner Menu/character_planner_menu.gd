@tool
extends EasyGrid

const StarRailLabelColumn = preload("res://Scenes/Character Planner Menu/star_rail_label_column.gd")
const STAR_RAIL_LABEL_COLUMN = preload("res://Scenes/Character Planner Menu/StarRail Label Column.tscn")
const INPUT_COLUMN = preload("res://Scenes/Character Planner Menu/Input Column.tscn")

func _ready() -> void:
	for child in get_children():
		child.queue_free()
	add_star_rail_columns()

# ====================================================== #
#                        COLUMNS                         #
# ====================================================== #
func add_star_rail_columns():
	var column = StarRailLabelColumn.new()
	
	add_grid_column(STAR_RAIL_LABEL_COLUMN.instantiate())
	add_star_rail_input_column()
	return

func add_star_rail_input_column():
	var column = INPUT_COLUMN.instantiate()
	column.add_multiline_input_lv_container("Character", 80)
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

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
