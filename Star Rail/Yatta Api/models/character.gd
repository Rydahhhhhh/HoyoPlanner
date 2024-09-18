extends Resource

const Enums = preload("res://Star Rail/Yatta Api/enums.gd")

class CharacterStory extends Resource:
	@export var title: String
	@export var text: String

class CharacterVoice extends Resource:
	@export var title: String
	@export var text: String
	@export var audio: int

class CharacterScript extends Resource:
	@export var stories: Array[CharacterStory]
	@export var voices: Array[CharacterVoice]
	
class CharacterAscensionItem extends Resource:
	@export var id: int
	@export var amount: int

class SkillAdd extends Resource:
	# Skill that inceases its level because of an eidolon
	@export var id: int
	"""ID of the skill"""
	@export var level: int
	"""Level added to the skill"""

class CharacterEidolon extends Resource:
	@export var id: int
	@export var rank: int
	@export var name: String

	@export var params: Array[int]
	@export var description: String
	@export var skill_add_level_Array: Array[SkillAdd]
	# Array of skills that increase their level because of this eidolon
	@export var icon: String

	#@field_validator("description", mode="before")
	 #func _format_description(cls, v: str, values: Any) -> str:
		#params = values.data.get("params")
		#return replace_placeholders(format_str(v), params)
#
	#@field_validator("skill_add_level_Array", mode="before")
	 #func _convert_skill_add_level_Array(cls, v: dict[str, int] | None) -> Array[SkillAdd]:
		#return [SkillAdd(id=int(id_), level=level) for id_, level in v.items()] if v else []
#
	#@field_validator("icon", mode="before")
	 #func _convert_icon(cls, v: str) -> str:
		#return f"https://api.yatta.top/hsr/assets/UI/skill/{v}.png"


class SkillPromoteCostItem extends Resource:
	@export var id: int
	@export var amount: int


class SkillPromote extends Resource:
	@export var level: int
	@export var cost_items: Array[SkillPromoteCostItem]

	#@field_validator("cost_items", mode="before")
	 #func _convert_cost_items(cls, v: dict[str, dict[str, int] | None]) -> Array[SkillPromoteCostItem]:
		#return (
			#[SkillPromoteCostItem(id=int(id_), amount=a) for id_, a in v["costItems"].items()]
			#if v["costItems"]
			#else []
		#)


class Status extends Resource:
	@export var name: String
	@export var value: float
	@export var icon: String

	#@field_validator("icon", mode="before")
	 #func _convert_icon(cls, v: str) -> str:
		#return f"https://api.yatta.top/hsr/assets/UI/status/{v}.png"


class ExtraEffect extends Resource:
	@export var name: String
	@export var description: String
	@export var icon: String


class WeaknessBreak extends Resource:
	@export var type: String
	@export var value: int


class SkillPoint extends Resource:
	@export var type: String
	@export var value: int


class SkillArraySkill extends Resource:
	@export var id: int
	@export var name: String
	@export var tag: String
	@export var type: String

	@export var max_level: int# = Field(alias="maxLevel")
	@export var skill_points: Array[SkillPoint]# = Field(alias="skillPoints")
	@export var weakness_break: Array[WeaknessBreak]# = Field(alias="weaknessBreak")
	@export var description: String# | None
	@export var simplified_description: String# | None = Field(alias="descriptionSimple")

	@export var traces: Array[int]
	@export var eidolons: Array[int]
	@export var extra_effects: Array[ExtraEffect]# = Field(alias="extraEffects")
	@export var attack_type: String# | None = Field(alias="attackType")
	@export var damage_type: String# | None = Field(alias="damageType")
	@export var icon: String

	#params: dict[str, Array[float]] | None
#
	#@field_validator("skill_points", mode="before")
	 #func _convert_skill_points(cls, v: dict[str, int | None]) -> Array[SkillPoint]:
		#return [SkillPoint(type=k, value=v) for k, v in v.items()]
#
	#@field_validator("weakness_break", mode="before")
	 #func _convert_weakness_break(cls, v: dict[str, int] | None) -> Array[WeaknessBreak]:
		#return [WeaknessBreak(type=k, value=v) for k, v in v.items()] if v else []
#
	#@field_validator("simplified_description", mode="before")
	 #func _format_simplified_description(cls, v: str | None) -> str | None:
		#return format_str(v) if v else None
#
	#@field_validator("traces", mode="before")
	 #func _convert_traces(cls, v: Array[int] | None) -> Array[int]:
		#return v if v else []
#
	#@field_validator("eidolons", mode="before")
	 #func _convert_eidolons(cls, v: Array[int] | None) -> Array[int]:
		#return v if v else []
#
	#@field_validator("extra_effects", mode="before")
	 #func _convert_extra_effects(cls, v: Array[dict[str, Any]] | None) -> Array[ExtraEffect]:
		#return [ExtraEffect(**e) for e in v] if v else []
#
	#@field_validator("icon", mode="before")
	 #func _convert_icon(cls, v: str) -> str:
		#return f"https://api.yatta.top/hsr/assets/UI/skill/{v}.png"


class BaseSkill extends Resource:
	@export var id: int
	@export var name: String# | None
	@export var description: String# | None

	@export var point_type: String# = Field(alias="pointType")
	@export var point_position: String# = Field(alias="pointPosition")
	@export var max_level: int# = Field(alias="maxLevel")
	@export var is_funcault: String# = Field(alias="is funcault")

	@export var avatar_level_limit: int# | None = Field(alias="avatarLevelLimit")
	@export var avatar_promotion_limit: int# | None = Field(alias="avatarPromotionLimit")

	@export var skill_Array: Array[SkillArraySkill]# = Field(alias="skillArray")
	@export var status_Array: Array[Status]# = Field(alias="statusArray")
	@export var icon: String
	@export var params: Dictionary#[String, Array[float]] | None

	#var promote: Array[SkillPromote]

	#@field_validator("skill_Array", mode="before")
	 #func _convert_skill_Array(cls, v: dict[str, dict[str, Any]] | None) -> Array[SkillArraySkill]:
		#return [SkillArraySkill(id=int(s), **v[s]) for s in v] if v else []
#
	#@field_validator("status_Array", mode="before")
	 #func _convert_status_Array(cls, v: Array[dict[str, Any]] | None) -> Array[Status]:
		#return [Status(**s) for s in v] if v else []
#
	#@field_validator("icon", mode="before")
	 #func _convert_icon(cls, v: str) -> str:
		#if "SkillIcon" in v:
			#return f"https://api.yatta.top/hsr/assets/UI/skill/{v}.png"
		#return f"https://api.yatta.top/hsr/assets/UI/status/{v}.png"
#
	#@field_validator("promote", mode="before")
	 #func _convert_promote(cls, v: dict[str, dict[str, dict[str, int] | None]]) -> Array[SkillPromote]:
		#return [SkillPromote(level=int(p), costItems=v[p]) for p in v] if v else []  # type: ignore


class SkillTreeSkill extends Resource:
	@export var id: int
	@export var points_direction: String# | None = Field(alias="pointsDirection")
	@export var points: Array[int]

	#@field_validator("points", mode="before")
	#func _convert_points(cls, v: Array[int] | None) -> Array[int]:
		#return v if v else []


class SkillTree extends Resource:
	@export var id: int
	@export var type: String
	@export var tree: Array[SkillTreeSkill]# = Field([])

	#@field_validator("tree", mode="before")
	 #func _convert_tree(cls, v: dict[str, dict[str, Any]]) -> Array[SkillTreeSkill]:
		#return [SkillTreeSkill(**v[s]) for s in v]


class CharacterTraces extends Resource:
	@export var main_skills: Array[BaseSkill]# = Field(alias="mainSkills")
	@export var sub_skills: Array[BaseSkill]# = Field(alias="subSkills")
	@export var tree_skills: Array[SkillTree]# = Field(alias="skillsTree")

	#@field_validator("main_skills", mode="before")
	 #func _convert_main_skills(cls, v: dict[str, dict[str, Any]]) -> Array[BaseSkill]:
		#return [BaseSkill(**v[s]) for s in v]
#
	#@field_validator("sub_skills", mode="before")
	 #func _convert_sub_skills(cls, v: dict[str, dict[str, Any]]) -> Array[BaseSkill]:
		#return [BaseSkill(**v[s]) for s in v]
#
	#@field_validator("tree_skills", mode="before")
	 #func _convert_tree_skills(cls, v: dict[str, dict[str, Any]]) -> Array[SkillTree]:
		#return [SkillTree(**v[s]) for s in v]


class CharacterCostItem extends Resource:
	@export var id: int
	@export var amount: int


class CharacterUpgrade extends Resource:
	@export var level: int
	@export var cost_items: Array[CharacterCostItem]# = Field(alias="costItems")
	@export var max_level: int# = Field(alias="maxLevel")
	@export var required_player_level: int# = Field(alias="playerLevelRequire")
	@export var required_world_level: int# = Field(alias="worldLevelRequire")
	@export var skill_base: Dictionary#dict[str, int | float] = Field(alias="skillBase")
	@export var skill_add: Dictionary#dict[str, int | float] = Field(alias="skillAdd")

	#@field_validator("cost_items", mode="before")
	 #func _convert_cost_items(cls, v: dict[str, int] | None) -> Array[CharacterCostItem]:
		#return [CharacterCostItem(id=int(k), amount=v) for k, v in v.items()] if v else []
#
	#@field_validator("required_player_level", mode="before")
	 #func _convert_required_player_level(cls, v: int | None) -> int:
		#return v if v else 0
#
	#@field_validator("required_world_level", mode="before")
	 #func _convert_required_world_level(cls, v: int | None) -> int:
		#return v if v else 0


class VoiceActor extends Resource:
	@export var lang: String
	@export var name: String


class CharacterInfo extends Resource:
	@export var faction: String
	@export var description: String
	@export var voice_actors: Array[VoiceActor]# = Field(alias="cv")

	#@field_validator("voice_actors", mode="before")
	 #func _convert_voice_actors(cls, v: dict[str, str] | None) -> Array[VoiceActor]:
		#return [VoiceActor(lang=k, name=v) for k, v in v.items()] if v else []


class CharacterDetailType extends Resource:
	@export var id: String
	@export var name: String

class CharacterDetailTypes extends Resource:
	@export var path_type: CharacterDetailType# = Field(alias="pathType")
	@export var combat_type: CharacterDetailType# = Field(alias="combatType")

class CharacterDetail extends Resource:
	@export var id: int
	@export var name: String
	@export var beta: bool# = Field(False)
	@export var rarity: int# = Field(alias="rank")
	@export var types: CharacterDetailTypes
	@export var icon: String
	@export var release: int
	@export var route: String
	@export var info: CharacterInfo# = Field(alias="fetter")
	@export var upgrades: Array[CharacterUpgrade]# = Field(alias="upgrade")
	@export var traces: CharacterTraces
	@export var eidolons: Array[CharacterEidolon]
	@export var ascension: Array[CharacterAscensionItem]
	@export var _script: CharacterScript
	@export var release_at: int #datetime.datetime | None = Field(None, alias="release")

	#@field_validator("icon", mode="before")
	 #func _convert_icon(cls, v: str) -> str:
		#return f"https://api.yatta.top/hsr/assets/UI/avatar/{v}.png"
#
	#@field_validator("eidolons", mode="before")
	 #func _convert_eidolons(cls, v: dict[str, dict[str, Any]]) -> Array[CharacterEidolon]:
		#return [CharacterEidolon(**v[s]) for s in v]
#
	#@field_validator("ascension", mode="before")
	 #func _convert_ascension(cls, v: dict[str, int]) -> Array[CharacterAscensionItem]:
		#return [CharacterAscensionItem(id=int(k), amount=v) for k, v in v.items()]
#
	#@field_validator("release_at", mode="before")
	 #func _convert_release_at(cls, v: int | None) -> datetime.datetime | None:
		#return datetime.datetime.fromtimestamp(v) if v else None
#
	#@property
	 #func medium_icon(self) -> str:
		#return self.icon.replace("avatar", "avatar/medium")
#
	#@property
	 #func large_icon(self) -> str:
		#return self.icon.replace("avatar", "avatar/large")
#
	#@property
	 #func round_icon(self) -> str:
		#return self.icon.replace("avatar", "avatar/round")


class CharacterType extends Resource:
	@export var path_type: String# = Field(alias="pathType")
	@export var combat_type: String# = Field(alias="combatType")


class Character extends Resource:
	@export var id: int
	@export var name: String
	@export var rarity: int
	@export var icon: String: get = _icon
	@export var types: CharacterType
	@export var route: String
	@export var beta: bool = false
	@export var release_at: int 
	
	var medium_icon: String: 
		get(): return icon.replace("avatar", "avatar/medium")
	
	var large_icon: String: 
		get(): return icon.replace("avatar", "avatar/large")
	
	var round_icon: String: 
		get(): return icon.replace("avatar", "avatar/round")
	
	func _icon():
		return "https://api.yatta.top/hsr/assets/UI/avatar/%s.png" % icon
	
	func _init(data: Dictionary) -> void:
		return
	
	func _get(property: StringName) -> Variant:
		match property:
			"rank": return self.rarity 
			"release": return self.release_at
		
		return
#
	#@field_validator("release_at", mode="before")
	 #func _convert_release_at(cls, v: int | None) -> datetime.datetime | None:
		#return datetime.datetime.fromtimestamp(v) if v else None
#
