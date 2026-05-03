extends Node2D

@onready var ui: UIManager = %UI

func _ready() -> void:
	ui.build_site_requested.connect(build_site)
	SaveLoadManager.load_game()

func build_site() -> void:
	var site_def: SiteDefinition = load("uid://br4iab62rnsso") as SiteDefinition
	var site_runtime: SiteRuntime = ResourceRuntimeBuilder.build_site(site_def)

	debug_print_site(site_runtime)

func debug_print_site(site: SiteRuntime) -> void:
	print("\n=== SITE ===")
	print("site_key: ", site.site_key)
	print("origin_path: ", site.origin_path)

	for container_id in site.containers:
		var container: ContainerRuntime = site.containers[container_id]
		debug_print_container(container, container_id, 1)

func debug_print_container(container: ContainerRuntime, entry_id: StringName, indent: int) -> void:
	var pad := "  ".repeat(indent)

	print("\n%s[Container] entry_id: %s" % [pad, entry_id])
	print("%skey: %s" % [pad, container.container_key])
	print("%spath: %s" % [pad, container.origin_path])

	for socket_id in container.sockets:
		var socket: SocketRuntime = container.sockets[socket_id]
		debug_print_socket(socket, socket_id, indent + 1)
		
func debug_print_socket(socket: SocketRuntime, entry_id: StringName, indent: int) -> void:
	var pad := "  ".repeat(indent)

	print("\n%s[Socket] entry_id: %s" % [pad, entry_id])
	print("%skey: %s" % [pad, socket.socket_key])
	print("%spath: %s" % [pad, socket.origin_path])

	if socket.items != null:
		debug_print_items(socket.items, indent + 1)
	else:
		print("%s(no item)" % pad)

func debug_print_items(items: Array[ItemRuntime], indent: int) -> void:
	var pad := "  ".repeat(indent)
	for i in items:		
		print("\n%s[Item]" % pad)
		print("%sdef_key: %s" % [pad, i.definition.item_key])
		print("%sinstance_id: %s" % [pad, i.save_state.instance_id])
		print("%sorigin_path: %s" % [pad, i.save_state.origin_path])
		print("%scurrent_location: %s" % [pad, i.save_state.current_location_path])
		print("%sdurability: %d" % [pad, i.save_state.durability])
		print("%stotal_damage: %d" % [pad, i.total_damage()])
