@tool
extends VBoxContainer

const INPUT_LV_CONTAINER = preload("res://Scenes/Character Planner Menu/InputLv Container.tscn")

static var input_nodes = {}
var my_input_nodes = []

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			for input_node in my_input_nodes:
				input_nodes[input_node.name].erase(input_node)

# ====================================================== #
#                      ROW CREATION                      #
# ====================================================== #
func add_node(node, name_as: String):
	assert(not get_node_or_null(name_as))
	add_child(node, true)
	
	node.owner = self
	
	if not name_as.is_empty():
		node.name = name_as
	
	my_input_nodes.append(node)
	input_nodes.get_or_add(node.name, []).append(node)
	
	return node

func add_input_lv_container(preset: String, name_as: String, max_lv: int):
	var input_lv_container = INPUT_LV_CONTAINER.instantiate()
	add_node(input_lv_container, name_as)
	input_lv_container.add_to_group("INPUT_LV_CONTAINER")
	
	print(input_lv_container.max_lv)
	
	input_lv_container.input_lv.max_lv = max_lv
	input_lv_container.set_preset(preset)
	
	var nodes_in_row = input_nodes[input_lv_container.name]
	if input_lv_container != nodes_in_row[-1]:
		var next_node = nodes_in_row[-1].input_lv
		next_node.input_lv.lv_changed.connect(input_lv_container.set_min_lv)
	
	# Return for chaining if needed
	return input_lv_container

func add_check_box(name_as: String):
	var check_box = CheckBox.new()
	add_node(CheckBox.new(), name_as)
	
	#if not check_box.is_node_ready():
		#await check_box.ready
	check_box.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	
	return check_box
# ====================================================== #
#                      ROW EDITING                       #
# ====================================================== #
static func test():
	pass

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
