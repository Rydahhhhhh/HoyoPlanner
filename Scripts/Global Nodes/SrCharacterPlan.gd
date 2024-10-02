@tool
extends EasyGrid

@onready var sr_label_column: VBoxContainer = %SrLabelColumn
@onready var sr_input_column: VBoxContainer = %SrInputColumn

func _ready() -> void:
	add_grid_column(sr_label_column)
	add_grid_column(sr_input_column)
