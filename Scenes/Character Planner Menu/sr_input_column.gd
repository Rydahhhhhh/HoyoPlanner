@tool
extends VBoxContainer

# For variable typing
const ExpandedIntInput = preload("res://Scenes/Character Planner Menu/expanded_int_input.gd")
const SimpleIntInput = preload("res://Scenes/Character Planner Menu/simple_int_input.gd")

const ascension_max_levels := [
	{"character": 20, "basic_attack": 1, "skill": 1, "ultimate": 1, "talent": 1},
	{"character": 30, "basic_attack": 1, "skill": 2, "ultimate": 2, "talent": 2},
	{"character": 40, "basic_attack": 2, "skill": 3, "ultimate": 3, "talent": 3},
	{"character": 50, "basic_attack": 3, "skill": 4, "ultimate": 4, "talent": 4},
	{"character": 60, "basic_attack": 4, "skill": 6, "ultimate": 6, "talent": 6},
	{"character": 70, "basic_attack": 5, "skill": 8, "ultimate": 8, "talent": 8},
	{"character": 80, "basic_attack": 6, "skill": 10, "ultimate": 10, "talent": 10}
]

func get_max_levels(of: String):
	return ascension_max_levels.map(func(d): return d.character)

func get_max_level(asc: int, of: String):
	return ascension_max_levels[asc][of]

@onready var character_level: ExpandedIntInput = %CharacterLevel
@onready var basic_attack_level: IntInputCell = %BasicAttackLevel
@onready var skill_level: IntInputCell = %SkillLevel
@onready var ultimate_level: IntInputCell = %UltimateLevel
@onready var talent_level: IntInputCell = %TalentLevel

func _ready() -> void:
	character_level.switch_validator = ascension_switch_validator
	character_level.switch_disable_condition = ascension_switch_disable
	return

func ascension_switch_validator(to: bool):
	var at_lowest_ascension = character_level.value < get_max_level(0, "character")
	var at_highest_ascension = character_level.value > get_max_level(-2, "character")
	var at_ascension_level = character_level.value in get_max_levels("character")
	
	if at_lowest_ascension:
		return false
	if at_ascension_level and not at_highest_ascension:
		return to
	
	return true

func ascension_switch_disable(value: bool):
	var at_ascension_level = character_level.value in get_max_levels("character")
	var at_highest_ascension = character_level.value > get_max_level(-2, "character")
	
	if at_ascension_level and not at_highest_ascension:
		return false
	
	return true
