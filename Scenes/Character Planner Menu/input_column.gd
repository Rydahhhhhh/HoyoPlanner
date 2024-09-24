@tool
extends VBoxContainer

@onready var line_edit_nodes = [
	%"Input Character Lv", 
	%"Input BAtk Lv", 
	%"Input Skill Lv", 
	%"Input Ultimate Lv", 
	%"Input Talent Lv"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for line_edit_nodes in line_edit_nodes:
		line_edit_nodes.text_changed.connect(text_input_changed.bind(line_edit_nodes))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_data(data: Dictionary):
	return

func text_input_changed(new_text: String, line_edit_node: LineEdit):
	validate_int_input(new_text, line_edit_node)

func validate_int_input(new_text: String, line_edit_node: LineEdit) -> void:
	var results = RegEx.create_from_string(r"\D+").search_all(new_text)
	results.reverse()
	for result in results:
		line_edit_node.delete_text(result.get_start(), result.get_end())
