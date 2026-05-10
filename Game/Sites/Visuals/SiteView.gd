extends Control
class_name SiteView

@export var container_view_scene: PackedScene
@onready var container_holder: Control = %ContainerHolder

var site: SiteRuntime

func bind(new_site: SiteRuntime) -> void:
	site = new_site
	_clear()

	for container in site.containers.values():
		var container_view := container_view_scene.instantiate()
		container_holder.add_child(container_view)
		container_view.bind(container)

func _clear() -> void:
	for child in container_holder.get_children():
		child.queue_free()
