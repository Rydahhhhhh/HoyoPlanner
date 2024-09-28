@tool
extends VBoxContainer

signal value_changed(to)
signal preset_changed(to: String)
const input_lv_properties = ["lv", "min_lv", "max_lv", "lv_changed", "min_lv_changed", "max_lv_changed", "set_lv", "set_min_lv", "set_max_lv"]

enum ValidPresets {NONE, SIMPLE, EXPANDED, CHECKBOX}

@export var preset: ValidPresets = ValidPresets.NONE: set = _set_preset
@onready var hidden_row: Control = $"Hidden Row"
@onready var rows = []

@onready var input_int: LineEdit = %"Input Int"
@onready var input_add: Button = %"Input Add"
@onready var input_sub: Button = %"Input Sub"
@onready var input_max: Button = %"Input Max"
@onready var input_cycle: Button = %"Input Cycle"
@onready var input_switch: CheckButton = %"Input Switch"
@onready var input_check_box: CheckBox = %"Input CheckBox"

var preset_data = {}
var main_input = null
var _preset = null

# ====================================================== #
#                       OVERRIDES                        #
# ====================================================== #
func _ready() -> void:
	if not Engine.is_editor_hint():
		hidden_row.queue_free()

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_SORT_CHILDREN:
			# Ensures the +1 and -1 Buttons have the same width
			var add_sub_btn_size = max(input_add.get_minimum_size().x, input_sub.get_minimum_size().x)
			input_add.custom_minimum_size.x = add_sub_btn_size
			input_sub.custom_minimum_size.x = add_sub_btn_size
		NOTIFICATION_EDITOR_PRE_SAVE:
			_preset = preset
			preset = ValidPresets.NONE
		NOTIFICATION_EDITOR_POST_SAVE:
			preset = _preset

func _set(property: StringName, value: Variant) -> bool:
	if is_node_ready() and property in input_lv_properties:
		input_int.set(property, value)
		return true
	return false

func _get(property: StringName) -> Variant:
	if is_node_ready() and property in input_lv_properties:
		return input_int.get(property)
	return

func _validate_property(property: Dictionary) -> void:
	return

# ====================================================== #
#                   SIGNAL CONNECTIONS                   #
# ====================================================== #
func add_pressed(): input_int.lv += 1
func sub_pressed(): input_int.lv -= 1
func max_pressed(): input_int.lv = input_int.max_lv
func cycle_pressed(): pass
func switch_pressed(): pass

# ====================================================== #
#                        PRESETS                         #
# ====================================================== #
static func get_preset_name(preset_n: ValidPresets):
	return ValidPresets.keys()[preset_n]

func set_preset(new_preset: ValidPresets, _preset_data: Dictionary = {}):
	preset_data = _preset_data
	return _set_preset(new_preset)

func _set_preset(new_preset: ValidPresets):
	if not is_node_ready():
		return
	
	var preset_name = get_preset_name(new_preset)
	var preset_fn_name = "preset %s" 
	preset_fn_name = preset_fn_name % preset_name.to_lower()
	preset_fn_name = preset_fn_name.replace(" ", "_")
	
	var preset_fn = get(preset_fn_name)
	if preset_fn != null:
		assert(preset_fn is Callable)
		
		if new_preset != ValidPresets.NONE:
			# Prevents calling it twice when setting preset to 'None'
			preset_none()
		preset_fn.call()
		
		preset = new_preset
		preset_changed.emit(new_preset)
	else:
		push_warning("No such preset %s" % new_preset)
	return

func get_row(n: int) -> HBoxContainer:
	while len(rows) < (n+1):
		var new_row = HBoxContainer.new()
		new_row.name = "InputCellRow"
		add_child.call_deferred(new_row, true)

		rows.append(new_row)
	return rows[n]

func add_to_row(row:int, nodes: Array[Node]):
	for node in nodes:
		get_row(row).add_child.call_deferred(node.duplicate())
	return

func preset_none():
	for row in rows.duplicate():
		row.queue_free()
		rows.erase(row)
	return

func preset_simple():
	add_to_row(0, [input_int, input_add, input_sub, input_max])
	return

func preset_expanded():
	add_to_row(0, [input_int, input_switch])
	add_to_row(1, [input_cycle, input_max])
	return

func preset_checkbox():
	add_to_row(0, [input_check_box])
	return
	
# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
