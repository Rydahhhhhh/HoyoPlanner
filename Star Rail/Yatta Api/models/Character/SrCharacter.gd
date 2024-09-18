class_name SrCharacter extends YattaResource

@export var id: int
@export var name: String
@export var rarity: int
@export var icon: String: get = _icon
@export var types: SrCharacterType
@export var route: String
@export var beta: bool = false
@export var release_at: int 

const alias := {
	"rarity": "rank",
	"release_at": "release"
}

var medium_icon: String: 
	get(): return icon.replace("avatar", "avatar/medium")

var large_icon: String: 
	get(): return icon.replace("avatar", "avatar/large")

var round_icon: String: 
	get(): return icon.replace("avatar", "avatar/round")

func _icon():
	return "https://api.yatta.top/hsr/assets/UI/avatar/%s.png" % icon

func property_alias(property: StringName):
	match property:
		"rarity": return "rank" 
		"release_at": return "release"
	return 
