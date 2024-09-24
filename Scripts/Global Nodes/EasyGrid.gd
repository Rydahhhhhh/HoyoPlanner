@tool
class_name EasyGrid extends HBoxContainer

var row_minh = {}

func _ready() -> void:
	if not is_config_correct():
		return

	#for vbox: VBoxContainer in get_children():
		#vbox.sort_children.connect(re_sort_children.bind('s'))
	
	return

func _get_configuration_warnings() -> PackedStringArray:
	for child in get_children():
		if child is not VBoxContainer:
			return ["Children must of VBoxContainer type"]
	return []


func re_sort_children(s = ""):
	print(s)
	if not is_config_correct():
		return
	
	row_minh = {}
	
	for vbox: VBoxContainer in get_children():
		for i in vbox.get_child_count():
			var ms = vbox.get_child(i).get_minimum_size()
			row_minh[i] = max(ms.y, row_minh.get(i, 0))
	
	for vbox: VBoxContainer in get_children():
		for child in vbox.get_children():
			child.custom_minimum_size.y = row_minh[child.get_index()]

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_SORT_CHILDREN:
			re_sort_children()

func is_config_correct():
	update_configuration_warnings()
	var warnings = _get_configuration_warnings()
	if warnings:
		if not Engine.is_editor_hint():
			push_error(warnings[0])
		return false
	return true
