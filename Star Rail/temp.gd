extends Control
const Character = preload("res://Star Rail/Yatta Api/models/character.gd").Character
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var chars = await Yatta.Client.fetch_characters()
	var x = Character.new({})
	ResourceSaver.save(x, "tet.tres")
	#print(chars)
	#print(await Yatta.Client.fetch_characters())
	get_tree().quit()
