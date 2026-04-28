extends RefCounted
class_name ApplicationState

var definition: ApplicationDefinition
@export_range(0, 6, 0.5) var mod: float = 0.0

func _init(def: ApplicationDefinition) -> void:
	definition = def

func get_total() -> float:
	return definition.base + mod

func reset_mod() -> void:
	mod = 0.0
