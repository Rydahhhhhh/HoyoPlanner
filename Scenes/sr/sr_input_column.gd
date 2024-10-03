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

var data = SrCharacterPlanStep.new()

@onready var character_level: ExpandedIntInput = %CharacterLevel
@onready var basic_attack_level: SimpleIntInput = %BasicAttackLevel
@onready var skill_level: SimpleIntInput = %SkillLevel
@onready var ultimate_level: SimpleIntInput = %UltimateLevel
@onready var talent_level: SimpleIntInput = %TalentLevel

@onready var passive_trace_1: CenterContainer = %PassiveTrace1
@onready var passive_trace_2: CenterContainer = %PassiveTrace2
@onready var passive_trace_3: CenterContainer = %PassiveTrace3
@onready var stat_trace_1: CenterContainer = %StatTrace1
@onready var stat_trace_2: CenterContainer = %StatTrace2
@onready var stat_trace_3: CenterContainer = %StatTrace3
@onready var stat_trace_4: CenterContainer = %StatTrace4
@onready var stat_trace_5: CenterContainer = %StatTrace5
@onready var stat_trace_6: CenterContainer = %StatTrace6
@onready var stat_trace_7: CenterContainer = %StatTrace7
@onready var stat_trace_8: CenterContainer = %StatTrace8
@onready var stat_trace_9: CenterContainer = %StatTrace9
@onready var stat_trace_10: CenterContainer = %StatTrace10

func _ready() -> void:
	character_level.value_changed.connect(data.set_last.bind("character_level"))
	basic_attack_level.value_changed.connect(data.set_last.bind("basic_attack_level"))
	skill_level.value_changed.connect(data.set_last.bind("skill_level"))
	ultimate_level.value_changed.connect(data.set_last.bind("ultimate_level"))
	talent_level.value_changed.connect(data.set_last.bind("talent_level"))
	
	passive_trace_1.value_changed.connect(data.set_last.bind("passive_trace_1"))
	passive_trace_2.value_changed.connect(data.set_last.bind("passive_trace_2"))
	passive_trace_3.value_changed.connect(data.set_last.bind("passive_trace_3"))
	stat_trace_1.value_changed.connect(data.set_last.bind("stat_trace_1"))
	stat_trace_2.value_changed.connect(data.set_last.bind("stat_trace_2"))
	stat_trace_3.value_changed.connect(data.set_last.bind("stat_trace_3"))
	stat_trace_4.value_changed.connect(data.set_last.bind("stat_trace_4"))
	stat_trace_5.value_changed.connect(data.set_last.bind("stat_trace_5"))
	stat_trace_6.value_changed.connect(data.set_last.bind("stat_trace_6"))
	stat_trace_7.value_changed.connect(data.set_last.bind("stat_trace_7"))
	stat_trace_8.value_changed.connect(data.set_last.bind("stat_trace_8"))
	stat_trace_9.value_changed.connect(data.set_last.bind("stat_trace_9"))
	stat_trace_10.value_changed.connect(data.set_last.bind("stat_trace_10"))
	
	character_level.switch_validator = _ascension_switch_validator
	character_level.switch_disable_condition = _ascension_switch_disable
	return

# ====================================================== #
#                      VALIDATORS                        #
# ====================================================== #
func _ascension_switch_validator(to: bool):
	var at_lowest_ascension = character_level.value < get_max_level(0, "character")
	var at_highest_ascension = character_level.value > get_max_level(-2, "character")
	var at_ascension_level = character_level.value in get_max_levels("character")
	
	if at_lowest_ascension:
		return false
	if at_ascension_level and not at_highest_ascension:
		return to
	
	return true

func _ascension_switch_disable(value: bool):
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
