@tool
class_name InputCell extends Container

signal value_changed(to)

enum ValidatorTypes {WARNING, PREVENT}

var delegated_properties: Array[Dictionary] = []

# ====================================================== #
#                       OVERRIDES                        #
# ====================================================== #
func _ready() -> void:
	return

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	
	properties.append_array(delegated_properties.map(parse_delegated_property))
	
	return properties

func _get(property: StringName) -> Variant:
	for data in delegated_properties:
		if property == data.alias:
			return data.node.get(data.property_name)
	return

func _set(property: StringName, value: Variant) -> bool:
	if property not in self and not is_node_ready():
		set_deferred(property, value)
		return true
	
	for data in delegated_properties:
		if property == data.alias:
			data.node.set(data.property_name, value)
			if data.update_editor:
				notify_property_list_changed()
			return true
	return false

# ====================================================== #
#                        SIGNALS                         #
# ====================================================== #
func _on_value_changed(to):
	value_changed.emit(to)

# ====================================================== #
#                         UTILS                          #
# ====================================================== #
static func get_property_in(what: Node, property_name: String):
	for property in what.get_property_list():
		if property.name == property_name:
			return property
	return

static func parse_delegated_property(data: Dictionary) -> Dictionary:
	var property = get_property_in(data.node, data.property_name)
	
	property.name = data.alias
	
	if data.editor != null:
		property.usage -= property.usage & PROPERTY_USAGE_EDITOR
		if data.editor:
			property.usage |= PROPERTY_USAGE_EDITOR
	return property

func delegate_property(to: Node, property_name: String, alias: String = "", update_editor: bool = false, editor = null):
	assert(to != null)
	var data = {
		"node": to, 
		"property_name": property_name, 
		"alias": alias, 
		"update_editor": update_editor, 
		"editor": editor
	}
	
	if alias.is_empty():
		data.alias = property_name
	
	assert(data.alias not in self, "Property '%s' already exists")
	
	if data not in delegated_properties:
		delegated_properties.append(data)
	
	notify_property_list_changed()
	return

func add_validator(validator_fn: Callable, validator_type: ValidatorTypes) -> void:
	# Exists to to ensure the signature is shared between inherited classes
	# May just get rid of it eventually
	push_warning("add_validator not overriden")
	return

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
