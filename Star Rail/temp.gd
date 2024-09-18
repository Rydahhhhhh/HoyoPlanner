extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chars = await Yatta.Client.fetch_characters()
	for c in chars:
		print(c.name)
	get_tree().quit()
