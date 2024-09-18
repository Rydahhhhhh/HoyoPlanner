class_name SrCharacter extends "res://Star Rail/Yatta Api/models/character base.gd"

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

func _init(data: Dictionary = {}) -> void:
	print_debug("help")
	print(123213)
	return

func _get(property: StringName) -> Variant:
	match property:
		"rank": return self.rarity 
		"release": return self.release_at
	
	return
