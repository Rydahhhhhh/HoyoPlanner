@tool
extends EasyGrid

@onready var sr_label_column: VBoxContainer = $SrLabelColumn
@onready var sripcol_test: VBoxContainer = $SripcolTest
@onready var sripcol_test_2: VBoxContainer = $SripcolTest2

func _ready() -> void:
	add_grid_column(sr_label_column)
	add_grid_column(sripcol_test)
	add_grid_column(sripcol_test_2)

func get_data():
	var data = []
	for child in get_children():
		if child != sr_label_column:
			data.append(child.get_data())
	return data
