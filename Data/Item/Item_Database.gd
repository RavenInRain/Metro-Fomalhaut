extends Node
class_name ItemDatabase

@export var items: Array[ItemDefinition] = []

var _item_lookup: Dictionary[StringName, ItemDefinition] = {}
var _is_built: bool = false

func _ready() -> void:
	_build_lookup()

# Creates a new Dictionary that stores item definitions by item_key.
func _build_lookup() -> void:
	# Clear item_lookup for a fresh start.
	_item_lookup.clear()
	
	# Go through the items array and create Dicitionary entries by key.
	for item_def: ItemDefinition in items:
		
		if item_def == null:
			print("ItemDatabase: null item definition detected")
			continue
		
		if item_def.item_key.is_empty():
			push_warning("ItemDatabase: item with empty key detected")
			continue
		
		# Duplicate check.
		if _item_lookup.has(item_def.item_key):
			push_warning("ItemDatabase: duplicate item_key '%s'" % item_def.item_key)
			continue
		
		_item_lookup[item_def.item_key] = item_def
		
	_is_built = true
	
# Fetch ItemDefinition from item_lookup by key.
func get_item_definition(key: StringName) -> ItemDefinition:
	# Check if it look_up was built, then build.
	if not _is_built:
		_build_lookup()

	# Fetch itemDefinition by key from item_lookup.
	var item_def: ItemDefinition = _item_lookup.get(key)
	if item_def == null:
		push_warning("ItemDatabase: missing item_key '%s'" % String(key))
	return item_def
