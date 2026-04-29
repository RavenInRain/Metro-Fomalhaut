extends RefCounted
class_name ItemFactory

static func gen_item_id(item_key: StringName) -> StringName:
	return StringName(
		"Item_%s_%s%d" % [
			String(item_key),
			IDHelper.get_random_letter(),
			randi() % 1000000
		]
	)

static func create_runtime(item_key: StringName) -> ItemRuntime:
	var def: ItemDefinition = ItemDatabase.definition_from_key(item_key)

	if def == null:
		push_error("No ItemDefinition found for item_key: %s" % item_key)
		return null

	var instance := ItemInstance.from_definition(def)
	instance.instance_id = gen_item_id(item_key)

	var item := ItemRuntime.new()
	item.definition = def
	item.instance = instance

	return item
