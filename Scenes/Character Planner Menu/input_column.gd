@tool
class_name InputColumn extends VBoxContainer

const INPUT_CELL = preload("res://Scenes/Character Planner Menu/InputCell.tscn")
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

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			for input_node in my_input_nodes:
				pass
				#input_nodes[input_node.name].erase(input_node)
		NOTIFICATION_EDITOR_PRE_SAVE:
			pass
		NOTIFICATION_EDITOR_POST_SAVE:
			pass

# ====================================================== #
#                      ROW CREATION                      #
# ====================================================== #
func add_cell(cell: Node, name_as: String = ""):
	assert(not get_node_or_null(name_as))
	add_child(cell, true)
	
	var x = input_rows
	var cell_index = cell.get_index()
	if len(input_rows) < cell_index:
		input_rows.resize(cell_index)
		input_rows[-1] = InputRow.new()
	input_rows[cell_index-1].add_cell(cell)
	
	cell.owner = self
	
	if not name_as.is_empty():
		cell.name = name_as
	
	return cell

func add_input_cell(preset: String, preset_data: Dictionary = {}):
	var input_cell = INPUT_CELL.instantiate()
	add_cell(input_cell)
	input_cell.set_preset(preset, preset_data)
	
	# Return for chaining if needed
	return input_cell

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
