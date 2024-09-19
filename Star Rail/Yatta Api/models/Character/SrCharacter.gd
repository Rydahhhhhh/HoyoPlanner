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

func _icon():
	return "https://api.yatta.top/hsr/assets/UI/avatar/%s.png" % icon

var medium_icon: String: 
	get(): return icon.replace("avatar", "avatar/medium")

var large_icon: String: 
	get(): return icon.replace("avatar", "avatar/large")

var round_icon: String: 
	get(): return icon.replace("avatar", "avatar/round")


#func load_icon():
	#Api.fetch(icon)
	#pass
#
#func load_medium_icon():
	#pass
#
#func load_large_icon():
	#pass
#
#func load_round_icon():
	#pass
