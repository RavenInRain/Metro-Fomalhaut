extends AuthoredSchema
## Item Preset for Sockets
class_name SiteContainerSchema

@export var container_def: ContainerDefinition

func get_container_key() -> StringName:
	return container_def.container_key if container_def != null else &""
