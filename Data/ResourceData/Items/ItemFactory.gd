extends RefCounted
class_name ItemFactory

## For creating new, unsaved items.
static func create_item_runtime(item_key: StringName) -> ItemRuntime:
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
static func create_from_instance_id(item_key: StringName, instance_id: String) -> ItemRuntime:
	var def: ItemDefinition = ItemDatabase.definition_from_key(item_key)
	var state: ItemSaveState = SaveLoadManager.get_item_state(item_key, instance_id)

	if state == null:
		push_error("Missing save state for instance_id: %s" % instance_id)
		return null

	var item: ItemRuntime = ItemRuntime.new()
	item.setup(def, state)
	return item
