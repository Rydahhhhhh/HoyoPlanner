class_name SrSkillTree extends YattaResource

const alias := {
	"REAL": "ALIAS",
}

@export var id: int
@export var type: String
@export var tree: Array[SrSkillTreeSkill]# = Field([])
