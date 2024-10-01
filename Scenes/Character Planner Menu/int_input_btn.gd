@tool
class_name IntInputBtn extends Button

signal cycled(to: int)

enum ButtonTypes {OPERATION, SET, CYCLE}
enum Operations {ADD, SUB, MUL, DIV, MOD}
enum SetTypes {MIN, MAX}

@export var int_input_edit: IntInputEdit
@export var type: ButtonTypes = ButtonTypes.OPERATION: set = _set_type

# Variables related to ButtonTypes.OPERATION
@export var operation: Operations = Operations.ADD
@export var operation_amount: int = 0: set = _set_operation_amount

# Variables related to ButtonTypes.SET
@export var set_to: SetTypes = SetTypes.MIN

# Variables related to ButtonTypes.CYCLE
@export var cycle_list: Array[int] = []
@export var hover_cycle_list: bool = false

# ====================================================== #
#                   SETTERS & GETTERS                    #
# ====================================================== #
func _set_operation_amount(to: int):
	if type != ButtonTypes.OPERATION:
		return
	operation_amount = to
	match operation:
		Operations.ADD: text = "+" + str(to)
		Operations.SUB: text = "-" + str(to)
		Operations.MUL: text = "*" + str(to)
		Operations.DIV: text = "/" + str(to)
		Operations.MOD: text = "%" + str(to)

# ====================================================== #
#                       FUNCTIONS                        #
# ====================================================== #
func _ready() -> void:
	mouse_default_cursor_shape = CURSOR_POINTING_HAND
	if not Engine.is_editor_hint():
		assert(int_input_edit != null)
		
		match type:
			ButtonTypes.CYCLE:
				if len(cycle_list) <= 0:
					push_warning("cycle_list empty; button will have no effect")

func _pressed() -> void:
	match type:
		ButtonTypes.OPERATION:
			match operation:
				Operations.ADD: int_input_edit.value += operation_amount
				Operations.SUB: int_input_edit.value -= operation_amount
				Operations.MUL: int_input_edit.value *= operation_amount
				Operations.DIV: int_input_edit.value /= operation_amount
				Operations.MOD: int_input_edit.value %= operation_amount
		ButtonTypes.SET:
			match set_to:
				SetTypes.MIN: int_input_edit.value = int_input_edit.min_value
				SetTypes.MAX: int_input_edit.value = int_input_edit.max_value
		ButtonTypes.CYCLE:
			int_input_edit.value = _get_next_cylce(int_input_edit.value)
			cycled.emit(int_input_edit.value)

# ====================================================== #
#                        EDITOR                          #
# ====================================================== #
func _set_type(to: ButtonTypes):
	type = to
	notify_property_list_changed()

func _validate_property(property: Dictionary) -> void:
	if type != ButtonTypes.OPERATION and property.name == "operation":
		property.usage = PROPERTY_USAGE_NONE
	if type != ButtonTypes.OPERATION and property.name == "operation_amount":
		property.usage = PROPERTY_USAGE_NONE
	if type != ButtonTypes.SET and property.name == "set_to":
		property.usage = PROPERTY_USAGE_NONE
	if type != ButtonTypes.CYCLE and property.name == "cycle_list":
		property.usage = PROPERTY_USAGE_NONE
	if type != ButtonTypes.CYCLE and property.name == "hover_cycle_list":
		property.usage = PROPERTY_USAGE_NONE

# ====================================================== #
#                        UTILS                           #
# ====================================================== #
func _get_next_cylce(from: int):
	if len(cycle_list) <= 0:
		return from
	
	# Return to the start of the cycle if it's greater or equal to the maximum value
	if cycle_list[-1] <= from:
		return cycle_list[0]
	
	# So to ensure 'from' will be different from it's current
	from += 1
	while not cycle_list.has(from):
		from += 1
		# While loop protectection, god save me
		assert(from < 1000)
	return from

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
