@tool
class_name IntInputCell extends InputCell

@onready var int_input: IntInputEdit = %IntInput

func _ready() -> void:
	super()
	
	int_input.value_changed.connect(_on_value_changed)
	delegate_property(int_input, "value", "value")
	delegate_property(int_input, "min_value", "min")
	delegate_property(int_input, "max_value", "max")

func add_validator(validator_fn: Callable, validator_type: ValidatorTypes) -> void:
	#int_input.add_validator(validator_fn)
	return

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
