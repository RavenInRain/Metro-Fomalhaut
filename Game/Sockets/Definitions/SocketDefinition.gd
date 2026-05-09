extends Resource
class_name SocketDefinition

## Items exist in Sockets.
@export var socket_key: StringName
@export var item_entries: Array[SocketItemSchema]
@export var capacity: int = -1 #unlimited by default.
