class_name SrSkillArraySkill extends YattaResource

const alias := {
	"max_level": "maxLevel",
	"skill_points": "skillPoints",
	"weakness_break": "weaknessBreak",
	"simplified_description": "descriptionSimple",
	"extra_effects": "extraEffects",
	"attack_type": "attackType",
	"damage_type": "damageType",
}

@export var id: int
@export var name: String
@export var tag: String
@export var type: String

@export var max_level: int
@export var skill_points: Array[SrSkillPoint]
@export var weakness_break: Array[SrWeaknessBreak]
@export var description: String
@export var simplified_description: String

@export var traces: Array[float]
@export var eidolons: Array[float]
@export var extra_effects: Array[SrExtraEffect]
@export var attack_type: String
@export var damage_type: String
@export var icon: String
