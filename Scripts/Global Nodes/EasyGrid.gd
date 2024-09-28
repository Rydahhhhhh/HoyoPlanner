@tool
class_name EasyGrid extends HBoxContainer

## A container that organizes its children into a pseudo-grid layout.
##
## A variant of [HBoxContainer] that organizes its children into a pseudo-grid layout. [VBoxContainer] children can be treated as "columns". Each column raises its child nodes to align with the highest child in any other column in the same row, creating a grid-like structure without explicitly defined rows.
## 
## @experimental

## Array storing children [VBoxContainer] to be treated as columns.
var grid_columns: Array[VBoxContainer] = [] 

# ====================================================== #
#                       OVERRIDES                        #
# ====================================================== #
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_THEME_CHANGED:
			update_minimum_size()
		NOTIFICATION_TRANSLATION_CHANGED, NOTIFICATION_LAYOUT_DIRECTION_CHANGED:
			queue_sort()
		NOTIFICATION_SORT_CHILDREN:
			var row_minh = {}
			
			# Removing any freed columns that weren't removed from the array
			for node in grid_columns.duplicate():
				if not is_instance_valid(node):
					grid_columns.erase(node)
			
			# I don't really know what happens when the children have expand
			# modes that aren't the default, and I don't really want to make it
			# work. I won't be doing that anyway - Rydahhhhh
			for node: VBoxContainer in grid_columns:
				for i in node.get_child_count():
					var ms = node.get_child(i).get_minimum_size()
					row_minh[i] = max(ms.y, row_minh.get(i, 0))
			
			for node: VBoxContainer in grid_columns:
				for child in node.get_children():
					child.custom_minimum_size.y = row_minh[child.get_index()]

# ====================================================== #
#                        METHODS                         #
# ====================================================== #
## Makes [param column] be treated as grid column, and forces it to become a child of this node, then re-sorts children.
func add_grid_column(column: VBoxContainer) -> VBoxContainer:
	if column not in grid_columns:
		grid_columns.append(column)
	
	if column.get_parent() == null:
		# When the child is newly created
		add_child(column, true)
		column.owner = self
	elif column.get_parent() != self:
		column.reparent(self)
	
	queue_sort()
	return column


## Stops treating [param column] as a grid column.[br]
## Set [param free] to [code]true[/code] if you wish for [param column] to be freed at the end of the current frame.
func remove_grid_column(column: VBoxContainer, free: bool = false) -> void:
	if free:
		column.queue_free()
	grid_columns.erase(column)
	queue_sort()
	return

# ====================================================== #
#                      END OF FILE                       #
# ====================================================== #
