extends RefCounted
class_name ItemRuntime

var definition: ItemDefinition
var save_state: ItemSaveState

var damage_mod: int = 1

func setup(def: ItemDefinition, state: ItemSaveState) -> void:
	definition = def
	save_state = state

#-# PROPERTY METHODS

func display_name() -> String:
	return definition.display_name

func total_damage() -> int:
	return definition.damage + damage_mod

func durability() -> int:
	return save_state.durability

func damage() -> int:
	return definition.damage
