@tool
extends VBoxContainer

signal preset_changed(to: String)

@export_enum("None", "Simple", "Expanded") var preset: String = "None": set = set_preset

@onready var input_lv_container_row_1: HBoxContainer = %"InputLvContainer Row 1"
@onready var input_lv_container_row_2: HBoxContainer = %"InputLvContainer Row 2"
@onready var input_lv_container_row_3: HBoxContainer = %"InputLvContainer Row 3"
@onready var input_lv_container_row_4: HBoxContainer = %"InputLvContainer Row 4"

@onready var input_lv: LineEdit = %InputLv
@onready var input_lv_add: Button = %"InputLv Add"
@onready var input_lv_sub: Button = %"InputLv Sub"
@onready var input_lv_max: Button = %"InputLv Max"
@onready var input_lv_cycle: Button = %"InputLv Cycle"
@onready var input_lv_switch: CheckButton = %"InputLv Switch"

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_SORT_CHILDREN:
			# Ensures the +1 and -1 Buttons have the same width
			var add_sub_btn_size = max(input_lv_add.get_minimum_size().x, input_lv_sub.get_minimum_size().x)
			input_lv_add.custom_minimum_size.x = add_sub_btn_size
			input_lv_sub.custom_minimum_size.x = add_sub_btn_size

# ====================================================== #
#                   SIGNAL CONNECTIONS                   #
# ====================================================== #
func add_pressed(): input_lv.lv += 1
func sub_pressed(): input_lv.lv -= 1
func max_pressed(): input_lv.lv = input_lv.max_lv
func cycle_pressed(): pass
func switch_pressed(): pass

# ====================================================== #
#                        PRESETS                         #
# ====================================================== #
func set_preset(new_preset: String):
	var preset_fn_name = "preset %s" 
	
	preset_fn_name = preset_fn_name % new_preset.to_lower()
	preset_fn_name = preset_fn_name.replace(" ", "_")
	
	var preset_fn = get(preset_fn_name)
	if preset_fn != null:
		assert(preset_fn is Callable)
		
		if new_preset != "None":
			# Prevents calling it twice when setting preset to 'None'
			preset_none()
		
		preset_fn.call()
		
		preset = new_preset
		preset_changed.emit(new_preset)
	else:
		push_warning("No such preset %s" % new_preset)
	return

func preset_none():
	input_lv_container_row_1.visible = false
	input_lv_container_row_2.visible = false
	input_lv_container_row_3.visible = false
	input_lv_container_row_4.visible = false
	
	input_lv.visible = false
	input_lv_add.visible = false
	input_lv_sub.visible = false
	input_lv_max.visible = false
	input_lv_cycle.visible = false
	input_lv_switch.visible = false
	
	input_lv.reparent(input_lv_container_row_1)
	input_lv_add.reparent(input_lv_container_row_1)
	input_lv_sub.reparent(input_lv_container_row_1)
	input_lv_max.reparent(input_lv_container_row_1)
	input_lv_cycle.reparent(input_lv_container_row_1)
	input_lv_switch.reparent(input_lv_container_row_1)
	return

func preset_simple():
	input_lv_container_row_1.visible = true
	
	input_lv.visible = true
	input_lv_add.visible = true
	input_lv_sub.visible = true
	input_lv_max.visible = true
	return

func preset_expanded():
	input_lv_container_row_1.visible = true
	input_lv_container_row_2.visible = true
	
	input_lv.visible = true
	input_lv_max.visible = true
	input_lv_cycle.visible = true
	input_lv_switch.visible = true
	
	input_lv_max.reparent(input_lv_container_row_2)
	input_lv_cycle.reparent(input_lv_container_row_2)
	return

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
