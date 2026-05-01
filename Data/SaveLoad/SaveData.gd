extends Resource
class_name SaveData

@export var game_version: String = ""
# Temp, will be replaced by comprehensive entity/global save logic.
@export var items: Array[ItemSaveState] = []

func find_item_state(item_key: StringName, instance_id: String) -> ItemSaveState:
	for state in items:
		if state.item_key == item_key and state.instance_id == instance_id:
			return state
	return null

func add_item_state(state: ItemSaveState) -> void:
	items.append(state)
