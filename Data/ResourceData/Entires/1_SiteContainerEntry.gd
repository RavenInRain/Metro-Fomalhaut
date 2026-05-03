extends AuthoredEntry
## Item Preset for Sockets
class_name SiteContainerEntry

@export var container_def: ContainerDefinition

func get_container_key() -> StringName:
	return container_def.container_key if container_def != null else &""
