extends RefCounted
class_name ContainerRuntime

var container_key: StringName
var origin_path: String
var sockets: Dictionary[StringName, SocketRuntime] = {}

func add_socket(schema_id: StringName, socket: SocketRuntime) -> void:
	sockets[schema_id] = socket
