@tool
extends InputCell

@onready var check_box: CheckBox = $CheckBox

# ====================================================== #
#                       OVERRIDES                        #
# ====================================================== #
func _ready() -> void:
	check_box.toggled.connect(_on_value_changed)
	delegate_property(check_box, "button_pressed", "value")
	return

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
