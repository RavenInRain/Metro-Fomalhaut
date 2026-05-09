extends RefCounted
class_name SocketRuntime

signal item_added(socket: SocketRuntime, item: ItemRuntime, index: int)
signal item_removed(socket: SocketRuntime, item: ItemRuntime, index: int)
signal items_reordered(socket: SocketRuntime)

var socket_key: StringName
var definition: SocketDefinition
var location_path: String
var items: Array[ItemRuntime] = []

# Append item to the items array.
func insert_item(item: ItemRuntime, index: int = -1) -> bool:
	if definition.capacity != -1 and items.size() >= definition.capacity:
		return false

	if index < 0 or index > items.size():
		index = items.size()

	items.insert(index, item)
	item.save_state.current_location_path = location_path

	item_added.emit(self, item, index)
	return true

# Remove specific item.
func remove_item(item: ItemRuntime) -> bool:
	var idx := items.find(item)
	if idx == -1:
		return false

	items.remove_at(idx)
	item_removed.emit(self, item, idx)
	return true

# Remove un-specific item by index.
func remove_item_at(index: int) -> ItemRuntime:
	if index < 0 or index >= items.size():
		return null

	var item := items[index]
	items.remove_at(index)
	item_removed.emit(self, item, index)
	return item

func move_item(from_index: int, to_index: int) -> void:
	if from_index == to_index:
		return
	if from_index < 0 or from_index >= items.size():
		return
	if to_index < 0 or to_index >= items.size():
		return

	var item := items[from_index]
	items.remove_at(from_index)
	items.insert(to_index, item)

	items_reordered.emit(self)
