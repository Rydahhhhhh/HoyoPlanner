@tool
class_name EasyGrid extends HBoxContainer

var row_minh = {}

func _ready() -> void:
	return

func _get_configuration_warnings() -> PackedStringArray:
	for child in get_children():
		if child is not VBoxContainer:
			return ["Children must of VBoxContainer type"]
	return []

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_SORT_CHILDREN:
			update_configuration_warnings()
			if _get_configuration_warnings():
				return
			
			row_minh = {}
			
			for vbox: VBoxContainer in get_children():
				for i in vbox.get_child_count():
					var ms = vbox.get_child(i).get_combined_minimum_size()
					row_minh[i] = max(ms.y, row_minh.get(i, 0))
			
			for vbox: VBoxContainer in get_children():
				for child in vbox.get_children():
					child.size.y = row_minh[child.get_index()]
