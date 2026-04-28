extends RefCounted
class_name DurabilityState

var definition: DurabilityDefinition

signal durability_changed(new_state: DurabilityDefinition.DurabilityStates)
signal item_destroyed

var durability_state: DurabilityDefinition.DurabilityStates:
	set(value):
		set_durability_state(value)

func _init(def: DurabilityDefinition) -> void:
	definition = def
	durability_state = def.initial_state

func set_durability_state(new_state: DurabilityDefinition.DurabilityStates) -> void:
	if durability_state == new_state:
		return

	if new_state == DurabilityDefinition.DurabilityStates.DESTROYED:
		return

	var old_state: DurabilityDefinition.DurabilityStates = durability_state
	durability_state = new_state

	durability_changed.emit(new_state)

	if old_state != DurabilityDefinition.DurabilityStates.DESTROYED \
	and new_state == DurabilityDefinition.DurabilityStates.DESTROYED:
		item_destroyed.emit()

#-# STATE CHECKS
func is_intact() -> bool:
	return durability_state == DurabilityDefinition.DurabilityStates.INTACT

func is_damaged() -> bool:
	return durability_state == DurabilityDefinition.DurabilityStates.DAMAGED

func is_destroyed() -> bool:
	return durability_state == DurabilityDefinition.DurabilityStates.DESTROYED
