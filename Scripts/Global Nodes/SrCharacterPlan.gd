@tool
extends EasyGrid

@onready var sr_label_column: VBoxContainer = %SrLabelColumn
@onready var sr_input_column: VBoxContainer = %SrInputColumn
@onready var sr_input_column_2: VBoxContainer = %SrInputColumn2

func _ready() -> void:
	add_grid_column(sr_label_column)
	add_grid_column(sr_input_column)
	add_grid_column(sr_input_column_2)

func get_plan_steps():
	return [sr_input_column.data, sr_input_column_2.data]

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
