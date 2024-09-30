@tool
extends IntInputCell


@export var Ascended: bool = false: set = _set_ascended, get = _get_ascended
@onready var is_ascended_btn: IsAscended = %IsAscended

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
