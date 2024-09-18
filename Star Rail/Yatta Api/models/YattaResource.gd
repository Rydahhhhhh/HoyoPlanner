class_name YattaResource extends Resource

signal resave

func _init(data: Dictionary = {}) -> void:
	for property in get_property_list():
		var prop_name = property.name
		
		if &"alias" in self:
			prop_name = self.alias.get(prop_name, prop_name)
		
		var val = data.get(prop_name, null)
		
		if val != null:
			assert(property.hint != TYPE_ARRAY)
			var prop_class = property.hint_string
			if prop_class != "":
				var cls_found = false
				for cls in ProjectSettings.get_global_class_list():
					if cls.class == prop_class:
						val = load(cls.path).new(val)
						cls_found = true
						break
				if not cls_found:
					push_error("No class found: " + prop_class)
			set(prop_name, val)

func _get(property: StringName) -> Variant:
	if property == &"alias":
		return
	
	if &"alias" in self:
		var alias = self.alias.find_key(str(property))
		if alias != null:
			return get(alias)
	return
	
func _set(property: StringName, value: Variant) -> bool:
	#	Note to future me
	#	The 'x in self' is determined by _get
	# 	So an alias will return true
	if &"alias" in self:
		var alias = self.alias.find_key(str(property))
		if alias != null:
			set(alias, value)
			return true
	return false
