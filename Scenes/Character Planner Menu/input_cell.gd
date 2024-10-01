@tool
class_name InputCell extends Container

signal value_changed(to)

enum ValidatorTypes {WARNING, PREVENT}

var delegated_properties: Array[Dictionary] = []
var delegated_properties_data := {}

# ====================================================== #
#                       OVERRIDES                        #
# ====================================================== #
func _ready() -> void:
	return

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	
	properties.append_array(delegated_properties)
	
	return properties

func _get(property: StringName) -> Variant:
	if property in delegated_properties_data:
		var property_data = delegated_properties_data[property]
		return property_data.node.get(property_data.property_name)
	return

func _set(property: StringName, value: Variant) -> bool:
	if property not in self and not is_node_ready():
		set_deferred(property, value)
		return true
	#if property in stored_properties and not is_node_ready():
		#set_deferred(property, value)
		#return true
	
	if property in delegated_properties_data:
		var property_data = delegated_properties_data[property]
		property_data.node.set(property_data.property_name, value)
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

func delegate_property(to: Node, property_name: String, export_as: String = "", store: bool = true):
	assert(to != null)
	var property = get_property_in(to, property_name)
	
	assert(property != null)
	
	assert(property.usage <= 4102)
	property.usage = 4102
	property.name = export_as
	
	if not store or property.name == "value":
		property.usage -= PROPERTY_USAGE_STORAGE
		property.usage -= PROPERTY_USAGE_SCRIPT_VARIABLE
	
	
	assert(export_as not in delegated_properties_data)
	delegated_properties_data[export_as] = {"node": to, "property_name": property_name}
	
	assert(property not in delegated_properties)
	delegated_properties.append(property)
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
