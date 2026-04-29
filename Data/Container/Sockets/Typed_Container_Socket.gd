extends Resource
class_name SocketTypeResolver

enum SocketTypes {
	EMPTY,
	EQUIPMENT,
	BUNDLE
}

func get_socket_type(contents: Array[ItemRuntime]) -> SocketTypes:
	match contents.size():
		0:
			return SocketTypes.EMPTY
		1:
			return SocketTypes.EQUIPMENT
		_:
			return SocketTypes.BUNDLE
