class_name YattaResource extends Resource

func _init(data: Dictionary = {}) -> void:
	for property in get_property_list():
		var val = data.get(property.name, null)
		
		if val != null:
			assert(property.hint != TYPE_ARRAY)
			var prop_class = property.hint_string
			if  prop_class != "":
				for cls in ProjectSettings.get_global_class_list():
					if cls.class == prop_class:
						val = load(cls.path).new(val)
						break
				push_error("No class found: " + prop_class)
			set(property.name, val)
