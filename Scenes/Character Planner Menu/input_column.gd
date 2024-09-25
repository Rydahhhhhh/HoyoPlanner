@tool
extends VBoxContainer

const INPUT_LV_CONTAINER_SINGLE_LINE = preload("res://Scenes/Character Planner Menu/InputLv Container SingleLine.tscn")
const INPUT_LV_CONTAINER_MULTI_LINE = preload("res://Scenes/Character Planner Menu/InputLv Container MultiLine.tscn")

func _ready() -> void:
	pass
# ====================================================== #
#                      ROW CREATION                      #
# ====================================================== #
func add_multiline_input_lv_container(container_name_suffix: String, max_lv: int):
	var input_lv_container = INPUT_LV_CONTAINER_MULTI_LINE.instantiate()
	add_child(input_lv_container)
	input_lv_container.name = "InputLv Container %s" % container_name_suffix
	await input_lv_container.ready
	input_lv_container.input_lv.max_lv = max_lv

func add_input_lv_container(container_name_suffix: String, max_lv: int):
	var input_lv_container = INPUT_LV_CONTAINER_SINGLE_LINE.instantiate()
	add_child(input_lv_container)
	input_lv_container.name = "InputLv Container %s" % container_name_suffix
	await input_lv_container.ready
	input_lv_container.input_lv.max_lv = max_lv
	
func add_check_box(container_name_suffix: String):
	var check_box = CheckBox.new()
	add_child(check_box)
	check_box.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	return

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
