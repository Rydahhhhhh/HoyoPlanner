class_name SrCharacterUpgrade extends YattaResource

@export var level: int
@export var cost_items: Array[SrCharacterCostItem]
@export var max_level: int
@export var required_player_level: int
@export var required_world_level: int
@export var skill_base: Dictionary
@export var skill_add: Dictionary

const alias := {
	"cost_items": "costItems",
	"max_level": "maxLevel",
	"required_player_level": "playerLevelRequire",
	"required_world_level": "worldLevelRequire",
	"skill_base": "skillBase",
	"skill_add": "skillAdd",
}
