extends RefCounted
class_name ItemTransferService

static func transfer_item(
	item: ItemRuntime,
	from_socket: SocketRuntime,
	to_socket: SocketRuntime,
	to_index: int = -1
) -> bool:
	if item == null:
		return false

	if not to_socket.can_accept_item(item):
		return false

	if not from_socket.remove_item(item):
		return false

	if not to_socket.insert_item(item, to_index):
		from_socket.insert_item(item) # rollback
		return false

	return true
