@tool
extends VBoxContainer

signal preset_changed(to: String)

@export_enum("None", "Simple", "Expanded") var preset: String = "None": set = set_preset

@onready var row_1: HBoxContainer = %"InputLvContainer Row 1"
@onready var row_2: HBoxContainer = %"InputLvContainer Row 2"
@onready var row_3: HBoxContainer = %"InputLvContainer Row 3"
@onready var row_4: HBoxContainer = %"InputLvContainer Row 4"

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
	if not is_node_ready():
		return
	
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
	row_1.set_deferred("visible", false)
	row_2.set_deferred("visible", false)
	row_3.set_deferred("visible", false)
	row_4.set_deferred("visible", false)
	
	input_lv.set_deferred("visible", false)
	input_lv_add.set_deferred("visible", false)
	input_lv_sub.set_deferred("visible", false)
	input_lv_max.set_deferred("visible", false)
	input_lv_cycle.set_deferred("visible", false)
	input_lv_switch.set_deferred("visible", false)
	
	input_lv.call_deferred("reparent", row_1)
	input_lv_add.call_deferred("reparent", row_1)
	input_lv_sub.call_deferred("reparent", row_1)
	input_lv_max.call_deferred("reparent", row_1)
	input_lv_cycle.call_deferred("reparent", row_1)
	input_lv_switch.call_deferred("reparent", row_1)
	return

func preset_simple():
	row_1.set_deferred("visible", true)
	
	input_lv.set_deferred("visible", true)
	input_lv_add.set_deferred("visible", true)
	input_lv_sub.set_deferred("visible", true)
	input_lv_max.set_deferred("visible", true)
	return

func preset_expanded():
	row_1.set_deferred("visible", true)
	row_2.set_deferred("visible", true)
	
	input_lv.set_deferred("visible", true)
	input_lv_max.set_deferred("visible", true)
	input_lv_cycle.set_deferred("visible", true)
	input_lv_switch.set_deferred("visible", true)
	
	input_lv_cycle.call_deferred("reparent", row_2)
	input_lv_max.call_deferred("reparent", row_2)
	return

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
