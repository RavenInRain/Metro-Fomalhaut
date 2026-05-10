extends Control

@export var item_view_scene: PackedScene

var socket: SocketRuntime
var item_view: ItemView

@onready var item_holder: Control = %ItemHolder

func bind(new_socket: SocketRuntime) -> void:
	socket = new_socket

	socket.item_added.connect(_on_items_changed)
	socket.item_removed.connect(_on_items_changed)
	socket.items_reordered.connect(_on_items_reordered)

	_refresh()

func _on_items_changed(_socket: SocketRuntime, _item: ItemRuntime, _index: int) -> void:
	_refresh()

func _on_items_reordered(_socket: SocketRuntime) -> void:
	_refresh()

func _refresh() -> void:
	for child in item_holder.get_children():
		child.queue_free()

	for item in socket.items:
		var view : ItemView = item_view_scene.instantiate()
		item_holder.add_child(view)
		view.bind(item)

func _on_item_changed(_socket: SocketRuntime, _item: ItemRuntime) -> void:
	_refresh()
