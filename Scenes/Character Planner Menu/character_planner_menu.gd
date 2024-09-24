@tool
extends EasyGrid

const INPUT_COLUMN = preload("res://Scenes/Character Planner Menu/Input Column.tscn")

@export var test: bool:
	set(v):
		_ready()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_grid_column(INPUT_COLUMN.instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
