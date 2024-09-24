@tool
class_name EasyGrid extends HBoxContainer

var row_minh = {}

@onready var label_columns: VBoxContainer = $"Label Columns"

@onready var grid_columns = [label_columns]

func _get_configuration_warnings() -> PackedStringArray:
	for node in grid_columns:
		if node is not VBoxContainer:
			return ["Nodes treated as grid must of VBoxContainer type"]
	return []

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_SORT_CHILDREN:
			re_sort_children()
		NOTIFICATION_THEME_CHANGED:
			update_minimum_size()
		NOTIFICATION_TRANSLATION_CHANGED, NOTIFICATION_LAYOUT_DIRECTION_CHANGED:
			queue_sort()

func is_config_correct():
	update_configuration_warnings()
	var warnings = _get_configuration_warnings()
	if warnings:
		if not Engine.is_editor_hint():
			push_error(warnings[0])
		return false
	return true

func re_sort_children():
	if not is_config_correct():
		return
	
	row_minh = {}
	
	for node: VBoxContainer in grid_columns:
		for i in node.get_child_count():
			var ms = node.get_child(i).get_minimum_size()
			row_minh[i] = max(ms.y, row_minh.get(i, 0))
	
	for node: VBoxContainer in grid_columns:
		for child in node.get_children():
			child.custom_minimum_size.y = row_minh[child.get_index()]

func add_grid_column(node: VBoxContainer):
	grid_columns.append(node)
	add_child(node, true)
	node.owner = self
	queue_sort()
