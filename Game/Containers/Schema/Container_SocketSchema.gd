extends AuthoredSchema
## Item Preset for Sockets
class_name ContainerSocketSchema

@export var socket_def: SocketDefinition

func get_socket_key() -> StringName:
	return socket_def.socket_key if socket_def != null else &""
