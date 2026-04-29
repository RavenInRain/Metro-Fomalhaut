extends RefCounted
## This is responsible for persistent, mutable Item data.  
class_name ItemInstance

var instance_id: String
var item_key: StringName
var instanced_durability: DurabilityInstance

static func from_definition(def: ItemDefinition) -> ItemInstance:
	var instance := ItemInstance.new()
	instance.item_key = def.item_key

	if def.durability != null:
		instance.instanced_durability = DurabilityInstance.new(def.durability)

	return instance
