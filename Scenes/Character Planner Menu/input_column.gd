@tool
class_name InputColumn extends VBoxContainer

const InputRow = preload("res://Scenes/Character Planner Menu/input_row.gd")

static var input_rows = []
static var input_columns = []
static var input_nodes = {}
var my_input_nodes = []

# ====================================================== #
#                       OVERRIDES                        #
# ====================================================== #
func _ready() -> void:
	add_to_group("INPUT_COLUMN")
	input_columns.append(self)
	
	for cell in get_children():
		var cell_index = cell.get_index()
		if len(input_rows) <= cell_index:
			input_rows.resize(cell_index+1)
			input_rows[-1] = InputRow.new()
		input_rows[cell_index].add_cell(cell)

# ====================================================== #
#                      ROW EDITING                       #
# ====================================================== #
func cell_value_changed(to, row: int):
	var next_column := get_next_column()
	if next_column == null:
		return
	
	return

func get_next_column() -> InputColumn:
	assert (input_columns.has(self) and not is_last_column())
	return input_columns[input_columns.find(self) + 1]

func get_prev_column() -> InputColumn:
	assert (input_columns.has(self) and not is_first_column())
	return input_columns[input_columns.find(self) - 1]

# ====================================================== #
#                         UTILS                          #
# ====================================================== #
func is_first_column(): return input_columns[0] == self
func is_last_column(): return input_columns[-1] == self

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
