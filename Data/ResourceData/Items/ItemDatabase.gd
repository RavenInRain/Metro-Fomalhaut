extends Node

var item_definitions: Dictionary[StringName, ItemDefinition] = {}

#-# SETUP
func _ready() -> void:
	load_items_from_folder("res://Assets/Item Definitions/")
	print("%s: ( %s ) %s." % [
		"Item Database loaded", 
		item_definitions.size(), 
		"Item Definitions loaded"])

func load_items_from_folder(path: String) -> void:
	var dir := DirAccess.open(path)
	if dir == null:
		push_error("Could not open item definition folder: %s" % path)
		return

	dir.list_dir_begin()
	var file_name := dir.get_next()

	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".tres"):
			var full_path := path.path_join(file_name)
			var item_def := load(full_path) as ItemDefinition

			if item_def != null:
				if item_definitions.has(item_def.item_key):
					push_warning("Duplicate item key: %s" % item_def.item_key)
				else:
					item_definitions[item_def.item_key] = item_def

		file_name = dir.get_next()

	dir.list_dir_end()

#-# UTILITY
func definition_from_key(item_key: StringName) -> ItemDefinition:
	return item_definitions.get(item_key, null)
