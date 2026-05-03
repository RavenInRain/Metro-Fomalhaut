extends RefCounted
class_name SiteRuntime

var site_key: StringName
var origin_path: String
var containers: Dictionary[StringName, ContainerRuntime] = {}

func add_container(entry_id: StringName, container: ContainerRuntime) -> void:
	containers[entry_id] = container
