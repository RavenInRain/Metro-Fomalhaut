extends Resource
class_name SaveData

#-# METADATA
@export var game_version: String = ""
@export var player_name: String = ""

#-# CONTENTS
# HACK: Will be replaced by comprehensive entity/global save logic.
@export var items: Array[ItemSaveState] = []

func find_item_state_by_origin_path(origin_path: String) -> ItemSaveState:
	for state in items:
		if state.origin_path == origin_path:
			return state
	return null

func find_item_state_key_and_id(item_key: StringName, instance_id: String) -> ItemSaveState:
	for state in items:
		if state.item_key == item_key and state.instance_id == instance_id:
			return state
	return null

func add_item_state(state: ItemSaveState) -> void:
	items.append(state)
