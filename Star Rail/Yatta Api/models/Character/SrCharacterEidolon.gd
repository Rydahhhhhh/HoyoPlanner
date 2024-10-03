class_name SrCharacterEidolon extends YattaResource

const alias = {
	"skill_add_level_Array": "skillAddLevelList"
}

@export var id: int
@export var rank: int
@export var name: String

@export var params: Array[float]
@export var description: String
@export var skill_add_level_Array: Array[SrSkillAdd]
# Array of skills that increase their level because of this eidolon
@export var icon: String
