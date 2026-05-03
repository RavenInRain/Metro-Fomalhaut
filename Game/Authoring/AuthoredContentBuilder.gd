extends RefCounted
class_name AuthoredContentBuilder

static func build_site(site_def: SiteDefinition) -> SiteRuntime:
	var site: SiteRuntime = SiteRuntime.new()
	site.site_key = site_def.site_key
	site.origin_path = String(site_def.site_key)

	for container_schema in site_def.container_entries:
		var container_path := "%s/%s" % [
			site.origin_path,
			container_schema.schema_id
		]

		var container: ContainerRuntime = build_container(
			container_schema.container_def,
			container_path
		)

		site.add_container(container_schema.schema_id, container)
	print("%s is built." % [site.site_key])
	return site

static func build_container(container_def: ContainerDefinition, origin_path: String) -> ContainerRuntime:
	var container := ContainerRuntime.new()
	container.container_key = container_def.container_key
	container.origin_path = origin_path

	for socket_schema in container_def.socket_entries:
		var socket_path := "%s/%s" % [
			origin_path,
			socket_schema.schema_id
		]

		var socket := build_socket(
			socket_schema.socket_def,
			socket_path
		)

		container.add_socket(socket_schema.schema_id, socket)

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
	item_entries: Array[SocketItemSchema]
) -> void:
	for item_schema in item_entries:
		var item: ItemRuntime = build_item_from_socket_schema(
			item_schema,
			socket.origin_path
		)

		if item != null:
			socket.insert_item(item)

static func build_item_from_socket_schema(
	item_schema: SocketItemSchema,
	socket_path: String
) -> ItemRuntime:
	if item_schema == null:
		push_error("Null ItemSocketschema at %s" % socket_path)
		return null

	if item_schema.schema_id == &"":
		push_error("ItemSocketschema has empty schema_id at %s" % socket_path)
		return null

	if item_schema.item_key == &"":
		push_error("ItemSocketschema has empty item_key at %s/%s" % [
			socket_path,
			item_schema.schema_id
		])
		return null

	if item_schema.initial_state == null:
		push_error("ItemSocketschema has no initial_state at %s/%s" % [
			socket_path,
			item_schema.schema_id
		])
		return null

	var item_path := "%s/%s" % [ socket_path, item_schema.schema_id ]

	return ItemFactory.create_item_from_authored_schema(
		item_schema.item_key,
		item_schema.initial_state,
		item_path
	)
