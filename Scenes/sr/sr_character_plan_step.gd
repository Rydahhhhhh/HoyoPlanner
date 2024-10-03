@tool
class_name SrCharacterPlanStep extends Resource

@export var character_level: int
@export var basic_attack_level: int
@export var skill_level: int
@export var ultimate_level: int
@export var talent_level: int

@export_category("Minor Traces")
@export var passive_trace_1: bool
@export var passive_trace_2: bool
@export var passive_trace_3: bool

@export var stat_trace_1: bool
@export var stat_trace_2: bool
@export var stat_trace_3: bool
@export var stat_trace_4: bool
@export var stat_trace_5: bool
@export var stat_trace_6: bool
@export var stat_trace_7: bool
@export var stat_trace_8: bool
@export var stat_trace_9: bool
@export var stat_trace_10: bool

## For binding 
func set_last(value: Variant, property: StringName):
	set(property, value)
	
