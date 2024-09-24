@tool
extends VBoxContainer

@onready var input_character_lv: LineEdit = %"Input Character Lv"
@onready var input_b_atk_lv: LineEdit = %"Input BAtk Lv"
@onready var input_skill_lv: LineEdit = %"Input Skill Lv"
@onready var input_ultimate_lv: LineEdit = %"Input Ultimate Lv"
@onready var input_talent_lv: LineEdit = %"Input Talent Lv"

@onready var line_edit_nodes = [
	input_character_lv, 
	input_b_atk_lv, 
	input_skill_lv, 
	input_ultimate_lv, 
	input_talent_lv
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
	
	var lv = line_edit_node.text as int
	
	var max = 0
	match line_edit_node:
		input_character_lv: max = 80
		input_b_atk_lv: max = 6
		input_skill_lv: max = 12
		input_ultimate_lv: max = 12
		input_talent_lv: max = 12
	
	if lv > max:
		line_edit_node.text = str(max)
		line_edit_node.caret_column = len(str(max))
	

func validate_int_input(new_text: String, line_edit_node: LineEdit) -> void:
	var results = RegEx.create_from_string(r"\D+").search_all(new_text)
	results.reverse()
	for result in results:
		line_edit_node.delete_text(result.get_start(), result.get_end())
	
	if line_edit_node.text.is_empty():
		line_edit_node.insert_text_at_caret("1")
