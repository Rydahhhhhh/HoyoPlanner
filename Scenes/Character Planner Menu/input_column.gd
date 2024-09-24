@tool
extends VBoxContainer

@onready var input_lv_character: LineEdit = %"InputLv Character"
@onready var input_lv_basic_atk: LineEdit = %"InputLv BasicAtk"
@onready var input_lv_skill: LineEdit = %"InputLv Skill"
@onready var input_lv_ultimate: LineEdit = %"InputLv Ultimate"
@onready var input_lv_talent: LineEdit = %"InputLv Talent"

@onready var input_lv_nodes = [
	input_lv_character, 
	input_lv_basic_atk, 
	input_lv_skill, 
	input_lv_ultimate, 
	input_lv_talent
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for input_lv_node in input_lv_nodes:
		input_lv_node.text_changed.connect(text_input_changed.bind(input_lv_node))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# ============================================================== #
#                           TEXT INPUT                           #
# ============================================================== #

func text_input_changed(new_text: String, input_lv_node: LineEdit):
	validate_int_input(new_text, input_lv_node)
	
	var max = 0
	match input_lv_node:
		input_lv_character: max = 80
		input_lv_basic_atk: max = 6
		input_lv_skill: max = 12
		input_lv_ultimate: max = 12
		input_lv_talent: max = 12
	
	var lv = input_lv_node.text as int
	
	if lv > max:
		input_lv_node.text = str(max)
		input_lv_node.caret_column = len(str(max))
	

func validate_int_input(new_text: String, input_lv_node: LineEdit) -> void:
	var results = RegEx.create_from_string(r"\D+").search_all(new_text)
	# Avoids possible indexing issues
	results.reverse()
	
	# Going to avoid settings the text directly when possible
	# Otherwise LineEdit sets the caret_column to 0
	for result in results:
		input_lv_node.delete_text(result.get_start(), result.get_end())
	
	# Currently, you aren't able to backspace on a single character 
	# May opt to settings this after focus is removed instead
	if input_lv_node.text.is_empty():
		input_lv_node.insert_text_at_caret("1")
