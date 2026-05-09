extends RefCounted
class_name ItemFactory

## For creating new, unsaved items.
static func create_item_runtime(
	item_key: StringName
) -> ItemRuntime:
	
	var def := ItemDatabase.definition_from_key(item_key)
	if def == null:
		push_error("No ItemDefinition found for item_key: %s" % item_key)
		return null

	var state: ItemSaveState = ItemSaveState.new()
	state.item_key = item_key
	state.instance_id = IDHelper.gen_resource_id(item_key)

	SaveLoadManager.register_item_state(state)

	var item := ItemRuntime.new()
	item.setup(def, state)

	return item

## For restoring items from saved instance IDs.
static func create_from_instance_id(
	item_key: StringName, 
	instance_id: String
) -> ItemRuntime:

	var def: ItemDefinition = ItemDatabase.definition_from_key(item_key)
	var state: ItemSaveState = SaveLoadManager.get_item_state(item_key, instance_id)

	if state == null:
		push_error("Missing save state for instance_id: %s" % instance_id)
		return null

	var item: ItemRuntime = ItemRuntime.new()
	item.setup(def, state)
	return item


static func create_item_from_authored_schema(
	item_key: StringName,
	initial_state: ItemSaveState,
	origin_path: String
) -> ItemRuntime:
	
	var def := ItemDatabase.definition_from_key(item_key)
	if def == null:
		push_error("Missing ItemDefinition for key: %s at %s" % [
			item_key,
			origin_path
		])
		return null

	var state := SaveLoadManager.current_save.find_item_state_by_origin_path(origin_path)

	if state == null:
		state = initial_state.duplicate(true) as ItemSaveState
		state.item_key = item_key
		state.instance_id = IDHelper.gen_resource_id(item_key)
		state.origin_path = origin_path
		state.current_location_path = origin_path
		SaveLoadManager.register_item_state(state)

	var item := ItemRuntime.new()
	item.setup(def, state)
	return item
