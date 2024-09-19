class_name YattaResource extends Resource

signal resave

func _init(data: Dictionary = {}) -> void:
	data.erase("script")
	# I am not dealing with that bruh
	
	for property in get_property_list():
		if property.usage != 4102:
			continue
		
		var prop_name = property.name
		
		if &"alias" in self:
			prop_name = self.alias.get(prop_name, prop_name)
		
		var val = data.get(prop_name, null)
		if val != null:
			var property_value = construct_property(property.type, property.hint_string, val)
			print(property_value)


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

static func construct_property(type: int, hint_string: String, value):
	match type:
		TYPE_INT, TYPE_STRING:
			return value
		TYPE_OBJECT:
			assert(value is Dictionary)
			for cls in ProjectSettings.get_global_class_list():
				if cls.class == hint_string:
					return load(cls.path).new(value)
			push_error("No class found: " + hint_string)
		TYPE_ARRAY:
			var nested_properties = []
		
			var nested_regex = RegEx.create_from_string(r"(?'type'\d*)\/(?'hint'\d*):(?'hint_string'\S*)")
			var regex_search = nested_regex.search(hint_string)
			
			# Type
			var nested_type = regex_search.get_string('type') as int
			# Property Hint String
			var nested_hint = regex_search.get_string('hint') as int
			# The Class stringname
			var nested_hint_string = regex_search.get_string('hint_string')
			
			assert(nested_type == TYPE_OBJECT)
			assert(nested_hint == PROPERTY_HINT_RESOURCE_TYPE)
			match typeof(value):
				TYPE_ARRAY:
					for nested_value in value:
						var nested_property = construct_property(nested_type, nested_hint_string, nested_value)
						nested_properties.append(nested_property)
				TYPE_DICTIONARY:
					var nested_property = construct_property(nested_type, nested_hint_string, {})
					var prope = nested_property.get_property_list()
					nested_properties.append(nested_property)
					assert(false)
				_:
					assert(false)
			return nested_properties
		_:
			assert(false)
	return
