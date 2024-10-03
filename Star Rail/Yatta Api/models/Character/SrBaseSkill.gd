class_name SrBaseSkill extends YattaResource

const alias := {
	"point_type": "pointType",
	"point_position": "pointPosition",
	"max_level": "maxLevel",
	"is_default": "isDefault",
	"avatar_level_limit": "avatarLevelLimit",
	"avatar_promotion_limit": "avatarPromotionLimit",
	"skill_Array": "skillList",
	"status_Array": "statusList",
}

@export var id: int
@export var name: String
@export var description: String

@export var point_type: String
@export var point_position: String
@export var max_level: int
@export var is_default: bool

@export var avatar_level_limit: int
@export var avatar_promotion_limit: int

@export var skill_Array: Array[SrSkillArraySkill]
@export var status_Array: Array[SrStatus]
@export var icon: String
@export var params: Dictionary

@export var promote: Array[SrSkillPromote]
