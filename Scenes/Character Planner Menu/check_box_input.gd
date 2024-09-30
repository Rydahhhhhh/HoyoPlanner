@tool
extends CenterContainer

signal toggled(toggled_on: bool)

@export var val: bool = false: set = _set_val, get = _get_val
@onready var check_box: CheckBox = $CheckBox

# ====================================================== #
#                       OVERRIDES                        #
# ====================================================== #
func _ready() -> void:
	return

# ====================================================== #
#                    SETTER & GETTERS                    #
# ====================================================== #
func _set_val(to: bool): 
	if not is_node_ready():
		await ready
	check_box.button_pressed = to

func _get_val(): 
	if not is_node_ready():
		await ready
	return check_box.button_pressed

# ====================================================== #
#                  SIGNAL CONNECTIONS                    #
# ====================================================== #
func _on_check_box_toggled(toggled_on: bool) -> void:
	toggled.emit(toggled_on)

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
