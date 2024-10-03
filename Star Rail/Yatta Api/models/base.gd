extends Node

const Utils = preload("res://Star Rail/Yatta Api/utils.gd")

#class BaseModel(_BaseModel):
	#@property
	#func fields(self) -> dict[str, Any]:
		##"""Return all fields of the model as a dictionary."""
		#var schema = self.model_fields
		#var field_names = schema.keys()
		#var field_values = {name: getattr(self, name) for name in field_names}
		#return field_values
#
	#@model_validator(mode="after")
	#func _format_fields(self) -> Self:
		#fields_to_format = {"name", "description", "story", "text"}
#
		#for field_name, field_value in self.fields.items():
			#if field_name in fields_to_format and isinstance(field_value, str):
				#setattr(self, field_name, format_str(field_value))
#
		#return self
