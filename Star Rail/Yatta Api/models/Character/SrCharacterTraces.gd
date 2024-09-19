class_name SrCharacterTraces extends YattaResource

const alias := {
	"main_skills": "mainSkills",
	"sub_skills": "subSkills",
	"tree_skills": "skillsTree",
}

@export var main_skills: Array[SrBaseSkill]
@export var sub_skills: Array[SrBaseSkill]
@export var tree_skills: Array[SrSkillTree]
