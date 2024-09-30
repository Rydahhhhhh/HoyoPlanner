@tool
extends IntInputCell

@onready var int_input_cycle: IntInputBtn = %IntInputCycle
@onready var input_switch: InputSwitch = %InputSwitch


# ====================================================== #
#                       FUNCTIONS                        #
# ====================================================== #
func _ready() -> void:
	#input_switch.value_changed.connect(_on_value_changed)
	delegate_property(input_switch, "value", "switch_value")
	delegate_property(int_input_cycle, "cycle_list", "Cycles")
	super()

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
