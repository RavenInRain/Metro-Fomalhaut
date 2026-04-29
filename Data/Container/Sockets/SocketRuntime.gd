class_name SocketRuntime
extends RefCounted

signal socket_contents_changed

var definition: SocketDefinition
var socket_contents: Array[ItemRuntime] = []
var socket_type: int = SocketTypeResolver.SocketTypes.EMPTY

func can_add_item(item: ItemRuntime) -> bool:
	if item == null:
		return false
	if socket_contents.size() >= definition.item_capacity:
		return false
	return true

func add_item(item: ItemRuntime) -> bool:
	if not can_add_item(item):
		return false

	socket_contents.append(item)
	_refresh_type()
	socket_contents_changed.emit()
	return true

func _refresh_type() -> void:
	if definition.type_resolver != null:
		socket_type = definition.type_resolver.get_socket_type(socket_contents)
