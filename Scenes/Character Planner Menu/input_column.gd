@tool
class_name InputColumn extends VBoxContainer

const INPUT_LV_CONTAINER = preload("res://Scenes/Character Planner Menu/InputLv Container.tscn")
const InputRow = preload("res://Scenes/Character Planner Menu/input_row.gd")

static var input_rows = []
static var input_columns = []
static var input_nodes = {}
var my_input_nodes = []

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			for input_node in my_input_nodes:
				pass
				#input_nodes[input_node.name].erase(input_node)

func _ready() -> void:
	add_to_group("INPUT_COLUMN")
	input_columns.append(self)

# ====================================================== #
#                      ROW CREATION                      #
# ====================================================== #
func add_cell(cell: Node, name_as: String = ""):
	assert(not get_node_or_null(name_as))
	add_child(cell, true)
	
	var cell_index = cell.get_index()
	if len(input_rows) < cell_index:
		input_rows.resize(cell_index)
		input_rows[-1] = InputRow.new()
	input_rows[cell_index].add_cell(cell)
	
	cell.owner = self
	
	if not name_as.is_empty():
		cell.name = name_as
	
	my_input_nodes.append(cell)
	input_nodes.get_or_add(cell.name, []).append(cell)
	#node.add_to_group("INPUT_CELL")
	
	cell.set_meta("row", cell.get_index())
	cell.set_meta("column", self)
	
	return cell

func add_input_lv_container(preset: String, max_lv: int):
	var input_lv_container = INPUT_LV_CONTAINER.instantiate()
	add_cell(input_lv_container)
	
	#input_lv_container.add_to_group("INPUT_LV_CONTAINER")
	#input_lv_container.lv_changed(on_value_changed.bind(input_lv_container.input_lv))
	
	input_lv_container.max_lv = max_lv
	input_lv_container.preset = preset
	
	var cell_on_changed_fn = cell_value_changed.bind(input_lv_container.get_index())
	input_lv_container.lv_changed.connect(cell_on_changed_fn)
	
	# This is ugly but it works
	#var nodes_in_row = input_nodes[input_lv_container.name]
	#if len(nodes_in_row) >= 2:
		#assert (nodes_in_row[-1] == input_lv_container)
		#input_lv_container.lv_changed.connect(nodes_in_row[-2].set_max_lv)
		#nodes_in_row[-2].lv_changed.connect(input_lv_container.set_min_lv)
		#input_lv_container.min_lv = nodes_in_row[-2].lv
		
	# Return for chaining if needed
	return input_lv_container

func add_check_box():
	var check_box = CheckBox.new()
	add_cell(CheckBox.new())
	
	#if not check_box.is_node_ready():
		#await check_box.ready
	check_box.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	
	return check_box
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
