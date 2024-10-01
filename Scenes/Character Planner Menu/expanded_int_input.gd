@tool
class_name ExpandedIntInput extends IntInputCell

@onready var int_input_cycle: IntInputBtn = %IntInputCycle
@onready var input_switch: InputSwitch = %InputSwitch

# Ideally these are typed as Callable, but there are weird inconsistencies when assigning null to a Callable typed variable
var switch_validator
var switch_disable_condition

# ====================================================== #
#                       FUNCTIONS                        #
# ====================================================== #
func _ready() -> void:
	super()
	delegate_property(input_switch, "value", "switch_value")
	delegate_property(int_input_cycle, "cycle_list", "Cycles")

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
