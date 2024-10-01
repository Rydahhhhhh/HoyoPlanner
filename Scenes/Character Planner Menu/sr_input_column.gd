@tool
extends VBoxContainer

const ascension_max_levels := [
	{"character": 20, "basic_attack": 1, "skill": 1, "ultimate": 1, "talent": 1},
	{"character": 30, "basic_attack": 1, "skill": 2, "ultimate": 2, "talent": 2},
	{"character": 40, "basic_attack": 2, "skill": 3, "ultimate": 3, "talent": 3},
	{"character": 50, "basic_attack": 3, "skill": 4, "ultimate": 4, "talent": 4},
	{"character": 60, "basic_attack": 4, "skill": 6, "ultimate": 6, "talent": 6},
	{"character": 70, "basic_attack": 5, "skill": 8, "ultimate": 8, "talent": 8},
	{"character": 80, "basic_attack": 6, "skill": 10, "ultimate": 10, "talent": 10}
]

@onready var character_level: ExpandedIntInput = %CharacterLevel
@onready var basic_attack_level: SimpleIntInput = %BasicAttackLevel
@onready var skill_level: SimpleIntInput = %SkillLevel
@onready var ultimate_level: SimpleIntInput = %UltimateLevel
@onready var talent_level: SimpleIntInput = %TalentLevel

@onready var passive_trace_1: CenterContainer = %PassiveTrace1
@onready var passive_trace_2: CenterContainer = %PassiveTrace2
@onready var passive_trace_3: CenterContainer = %PassiveTrace3
@onready var minor_trace_1: CenterContainer = %MinorTrace1
@onready var minor_trace_2: CenterContainer = %MinorTrace2
@onready var minor_trace_3: CenterContainer = %MinorTrace3
@onready var minor_trace_4: CenterContainer = %MinorTrace4
@onready var minor_trace_5: CenterContainer = %MinorTrace5
@onready var minor_trace_6: CenterContainer = %MinorTrace6
@onready var minor_trace_7: CenterContainer = %MinorTrace7
@onready var minor_trace_8: CenterContainer = %MinorTrace8
@onready var minor_trace_9: CenterContainer = %MinorTrace9
@onready var minor_trace_10: CenterContainer = %MinorTrace10

func _ready() -> void:
	character_level.switch_validator = ascension_switch_validator
	character_level.switch_disable_condition = ascension_switch_disable
	return

func get_data():
	var data = {}
	data["CharacterLevel"] = character_level.value
	data["BasicAttackLevel"] = basic_attack_level.value
	data["SkillLevel"] = skill_level.value
	data["UltimateLevel"] = ultimate_level.value
	data["TalentLevel"] = talent_level.value
	
	data["PassiveTrace1"] = passive_trace_1.value
	data["PassiveTrace2"] = passive_trace_2.value
	data["PassiveTrace3"] = passive_trace_3.value
	data["MinorTrace1"] = minor_trace_1.value
	data["MinorTrace2"] = minor_trace_2.value
	data["MinorTrace3"] = minor_trace_3.value
	data["MinorTrace4"] = minor_trace_4.value
	data["MinorTrace5"] = minor_trace_5.value
	data["MinorTrace6"] = minor_trace_6.value
	data["MinorTrace7"] = minor_trace_7.value
	data["MinorTrace8"] = minor_trace_8.value
	data["MinorTrace9"] = minor_trace_9.value
	data["MinorTrace10"] = minor_trace_10.value
	
	return data


# ====================================================== #
#                      VALIDATORS                        #
# ====================================================== #
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

# ====================================================== #
#                         UTILS                          #
# ====================================================== #
func get_max_levels(of: String):
	return ascension_max_levels.map(func(d): return d.character)

func get_max_level(asc: int, of: String):
	return ascension_max_levels[asc][of]

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
