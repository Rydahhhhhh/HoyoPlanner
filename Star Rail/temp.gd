extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chars = await Yatta.Client.fetch_characters()
	print( await Yatta.Client.fetch_characters())
	#var x = Character.new({})
	#print(chars)
	#print(await Yatta.Client.fetch_characters())
	get_tree().quit()
