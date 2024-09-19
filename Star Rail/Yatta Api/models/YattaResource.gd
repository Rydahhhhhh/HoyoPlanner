class_name YattaResource extends Resource

signal resave

func _init(data: Dictionary = {}) -> void:
	data.erase("script")
	# I am not dealing with that bruh
	
	for property in exported_properties():
		var prop_name = property.name
		
		if &"alias" in self:
			prop_name = self.alias.get(prop_name, prop_name)
		
		var val = data.get(prop_name, null)
		if val != null:
			var property_value = construct_property(property.type, property.hint_string, val)
			match property.type:
				TYPE_ARRAY:
					set(prop_name, [])
					# Types arrays moment
					get(prop_name).append_array(property_value)
				TYPE_STRING, TYPE_INT, TYPE_FLOAT, TYPE_DICTIONARY, TYPE_OBJECT:
					set(prop_name, property_value)
				_:
					assert(false)

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
	#	So an alias will return true
	#	Also mind the recursion
	
	if &"alias" in self:
		var alias = self.alias.find_key(str(property))
		if alias != null:
			set(alias, value)
			return true
	return false

func exported_properties():
	return get_property_list().filter(func(p): return p.usage == 4102)

func set_as_positional(position: int, value: Variant):
	var properties = exported_properties()
	assert(len(properties) > position, self.get_script().get_global_name() + " doesn't have enough properties")
	set(properties[position].name, value)
	return

static func construct_property(type: int, hint_string: String, value):
	match type:
		TYPE_INT, TYPE_FLOAT, TYPE_STRING, TYPE_DICTIONARY:
			return value
		TYPE_OBJECT:
			assert(value is Dictionary)
			for cls in ProjectSettings.get_global_class_list():
				if cls.class == hint_string:
					return load(cls.path).new(value)
			push_error("No class found: " + hint_string)
		TYPE_ARRAY:
			var nested_properties = []
			
			# See PROPERTY_HINT_TYPE_STRING in the docs
			var nested_regex = RegEx.create_from_string(r"(?'type'\d*)\/?(?'hint'\d*):?(?'hint_string'\S*)")
			var regex_search = nested_regex.search(hint_string)
			
			# The Type inside 
			var nested_type = regex_search.get_string('type') as int
			# Property Hint String (Usage hint)
			var nested_hint = regex_search.get_string('hint') as int
			# The Class stringname
			var nested_hint_string = regex_search.get_string('hint_string')
			
			if nested_hint != PROPERTY_HINT_RESOURCE_TYPE:
				push_warning("nested_hint != PROPERTY_HINT_RESOURCE_TYPE")
			#if vlaue is dictionary then convert the values into array and proccess value like that unless the dictionary values are not also dictionaries
			#if value is dictionary and the values of said values are dictionary then convert those values to an array, otherwise proccess it as positoni
			
			match typeof(value):
				TYPE_ARRAY:
					for nested_value in value:
						var nested_resource = construct_property(nested_type, nested_hint_string, nested_value)
						nested_properties.append(nested_resource)
				TYPE_DICTIONARY:
					#var value_types = value.values().map(typeof)
					# Assures the array only has 1 type
					#assert(not value_types.filter(func(v): return v not in value_types))
					
					for nested_key in value:
						var nested_value = value[nested_key]
						
						match typeof(nested_value):
							TYPE_DICTIONARY:
								var nested_resource = construct_property(nested_type, nested_hint_string, nested_value)
								nested_properties.append(nested_resource)
							TYPE_STRING, TYPE_INT, TYPE_FLOAT, TYPE_NIL:
								var nested_resource = construct_property(nested_type, nested_hint_string, {})
								
								nested_resource.set_as_positional(0, nested_key)
								nested_resource.set_as_positional(1, nested_value)
								
								nested_properties.append(nested_resource)
							_:
								assert(false, "Unknown nested_value type " + type_string(nested_value))
				_:
					assert(false, "Unknown value type " + type_string(value))
			return nested_properties
		_:
			assert(false, "Unknown type " + type_string(type))
	return
