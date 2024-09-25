@tool
extends EasyGrid

signal preset_changed(to: String)

const COLUMNS := {
	"SR": {
		"LABEL": preload("res://Scenes/Character Planner Menu/sr_label_column.tscn"),
		"INPUT": preload("res://Scenes/Character Planner Menu/sr_input_column.tscn")
	}
}

@export_enum("None", "SR", "GI", "ZZZ") var preset: String = "None": set = set_preset

func _ready() -> void:
	return

# ====================================================== #
#                        PRESETS                         #
# ====================================================== #
func set_preset(new_preset: String):
	if not is_node_ready():
		return
	
	for child in get_children():
		child.queue_free()
		grid_columns.erase(child)
	if new_preset != "None":
		assert(new_preset in COLUMNS)
		var label_column = add_grid_column(COLUMNS[new_preset]["LABEL"].instantiate())
		var input_column = add_grid_column(COLUMNS[new_preset]["INPUT"].instantiate())
		# I'll need to access character resource data for Star rail here
		# To get the traces data
	
	preset = new_preset
	return

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
