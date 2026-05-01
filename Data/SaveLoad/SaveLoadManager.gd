extends Node

const GAME_VERSION: String = "v0.001"
const SAVE_PATH: String = "user://saves/Save_01.tres"

var current_save: SaveData

func load_game() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		current_save = ResourceLoader.load(SAVE_PATH) as SaveData
	
	if current_save == null:
		current_save = SaveData.new()
		current_save.game_version = GAME_VERSION

func save_game() -> void:
	if current_save == null:
		current_save = SaveData.new()
		current_save.game_version = GAME_VERSION

	DirAccess.make_dir_recursive_absolute("user://saves")
	var err := ResourceSaver.save(current_save, SAVE_PATH)
	if err != OK:
		push_error("Failed to save game: %s" % err)

func get_item_state(item_key: StringName, instance_id: String) -> ItemSaveState:
	if current_save == null:
		load_game()
	return current_save.find_item_state(item_key, instance_id)

func register_item_state(state: ItemSaveState) -> void:
	if current_save == null:
		load_game()
	current_save.add_item_state(state)


#-# DEBUG
func debug_print_all_items() -> void:
	var save := SaveLoadManager.current_save
	if save == null:
		print("No save loaded")
		return

	for state in save.items:
		print(state)
