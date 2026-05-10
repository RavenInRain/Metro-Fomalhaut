extends Control
class_name ContainerView

@export var socket_view_scene: PackedScene
@onready var socket_holder: Control = %SocketHolder

var container: ContainerRuntime

func bind(new_container: ContainerRuntime) -> void:
	container = new_container

	for socket_id in container.sockets:
		var socket := container.sockets[socket_id]

		var socket_view := socket_view_scene.instantiate()
		socket_holder.add_child(socket_view)
		socket_view.bind(socket)
