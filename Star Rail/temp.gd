extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(await Yatta.Client.fetch_character_detail(1222))
	
	
	get_tree().quit()
