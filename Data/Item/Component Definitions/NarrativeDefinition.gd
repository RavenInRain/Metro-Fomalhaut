extends Resource
class_name NarrativeDefinition

@export var attack_nar: Array
@export var defend_nar: Array
@export var equipment_nar: String = ""

func roll_random_nar(arr: Array) -> String:
	var index: int = randi() % arr.size()
	var random_entry: String = arr[index]
	return random_entry
