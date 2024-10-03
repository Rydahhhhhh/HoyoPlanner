@tool
extends VBoxContainer

@onready var sr_character_plan: HBoxContainer = $SrCharacterPlan
@onready var button: Button = $Button


func _on_button_pressed() -> void:
	print(sr_character_plan.get_plan_steps())
