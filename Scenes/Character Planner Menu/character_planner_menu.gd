@tool
extends EasyGrid

signal preset_changed(to: String)
signal columns_changed

const COLUMNS := {
	"SR": {
		"LABEL": preload("res://Scenes/Character Planner Menu/sr_label_column.tscn"),
		"INPUT": preload("res://Scenes/Character Planner Menu/sr_input_column.tscn")
	}
}

var label_column = null
var input_column_min = null
var input_column_max = null
@export_custom(PROPERTY_HINT_ENUM, "None,SR,GI,ZZZ", PROPERTY_USAGE_NO_INSTANCE_STATE+4) var preset: String = "None": set = set_preset

func _ready() -> void:
	# Closing a scene in the editor then pressing CTRL+SHIFT+T will reopen the scene and call _ready
	# But it does not call setters for variables just assigns them
	preset = "None"
	if not Engine.is_editor_hint():
		preset = "SR"
	return

# ====================================================== #
#                        COLUMNS                         #
# ====================================================== #
func set_preset(new_preset: String):
	if not is_node_ready():
		return
	
	for child in get_children().duplicate():
		remove_grid_column(child)
	
	if new_preset != "None":
		print(new_preset)
		assert(new_preset in COLUMNS)
		
		label_column = add_grid_column(COLUMNS[new_preset]["LABEL"].instantiate())
		input_column_min = add_grid_column(COLUMNS[new_preset]["INPUT"].instantiate())
		input_column_max = add_grid_column(COLUMNS[new_preset]["INPUT"].instantiate())
		
		input_column_max.name = input_column_min.name + " Max" # Yes it's meant to be min not max
		input_column_min.name = input_column_min.name + " Min"
		
		
		columns_changed.emit()
		
	preset = new_preset
	return

func add_input_column():
	if preset == "None":
		return
	
	var new_column = add_grid_column(COLUMNS[preset]["INPUT"].instantiate())
	move_child(new_column, -2)
	
	columns_changed.emit()
	return

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
