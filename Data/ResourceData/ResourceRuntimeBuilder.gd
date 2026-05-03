extends RefCounted
class_name ResourceRuntimeBuilder

static func build_site(site_def: SiteDefinition) -> SiteRuntime:
	var site: SiteRuntime = SiteRuntime.new()
	site.site_key = site_def.site_key
	site.origin_path = String(site_def.site_key)

	for container_entry in site_def.container_entries:
		var container_path := "%s/%s" % [
			site.origin_path,
			container_entry.entry_id
		]

		var container: ContainerRuntime = build_container(
			container_entry.container_def,
			container_path
		)

		site.add_container(container_entry.entry_id, container)

	return site

static func build_container(container_def: ContainerDefinition, origin_path: String) -> ContainerRuntime:
	var container := ContainerRuntime.new()
	container.container_key = container_def.container_key
	container.origin_path = origin_path

	for socket_entry in container_def.socket_entries:
		var socket_path := "%s/%s" % [
			origin_path,
			socket_entry.entry_id
		]

		var socket := build_socket(
			socket_entry.socket_def,
			socket_path
		)

		container.add_socket(socket_entry.entry_id, socket)

	return container

#-# SOCKETS

static func build_socket(socket_def: SocketDefinition, origin_path: String) -> SocketRuntime:
	var socket := SocketRuntime.new()
	socket.socket_key = socket_def.socket_key
	socket.origin_path = origin_path

	build_item_entries_for_socket(socket, socket_def.item_entries)

	return socket

#-# ITEMS

static func build_item_entries_for_socket(
	socket: SocketRuntime,
	item_entries: Array[SocketItemEntry]
) -> void:
	for item_entry in item_entries:
		var item: ItemRuntime = build_item_from_socket_entry(
			item_entry,
			socket.origin_path
		)

		if item != null:
			socket.insert_item(item)

static func build_item_from_socket_entry(
	item_entry: SocketItemEntry,
	socket_path: String
) -> ItemRuntime:
	if item_entry == null:
		push_error("Null ItemSocketEntry at %s" % socket_path)
		return null

	if item_entry.entry_id == &"":
		push_error("ItemSocketEntry has empty entry_id at %s" % socket_path)
		return null

	if item_entry.item_key == &"":
		push_error("ItemSocketEntry has empty item_key at %s/%s" % [
			socket_path,
			item_entry.entry_id
		])
		return null

	if item_entry.initial_state == null:
		push_error("ItemSocketEntry has no initial_state at %s/%s" % [
			socket_path,
			item_entry.entry_id
		])
		return null

	var item_path := "%s/%s" % [ socket_path, item_entry.entry_id ]

	return ItemFactory.create_item_from_authored_entry(
		item_entry.item_key,
		item_entry.initial_state,
		item_path
	)
