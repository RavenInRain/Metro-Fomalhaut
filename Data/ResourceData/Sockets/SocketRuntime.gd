extends RefCounted
class_name SocketRuntime

var socket_key: StringName
var origin_path: String
var items: Array[ItemRuntime] = []

func insert_item(new_item: ItemRuntime) -> void:
	items.append(new_item)
	new_item.save_state.current_location_path = origin_path
