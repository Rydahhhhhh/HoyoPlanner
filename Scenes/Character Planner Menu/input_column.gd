@tool
extends VBoxContainer

const INPUT_LV_CONTAINER = preload("res://Scenes/Character Planner Menu/InputLv Container.tscn")

# ====================================================== #
#                      ROW CREATION                      #
# ====================================================== #

func add_input_lv_container(preset: String, container_name_suffix: String, max_lv: int):
	var input_lv_container = INPUT_LV_CONTAINER.instantiate()
	add_child(input_lv_container)
	
	input_lv_container.owner = self
	input_lv_container.name = "InputLv Container %s" % container_name_suffix
	input_lv_container.input_lv.max_lv = max_lv
	input_lv_container.set_preset(preset)
	
	return input_lv_container
	
func add_check_box(container_name_suffix: String):
	var check_box = CheckBox.new()
	add_child(check_box)
	check_box.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	return check_box

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
