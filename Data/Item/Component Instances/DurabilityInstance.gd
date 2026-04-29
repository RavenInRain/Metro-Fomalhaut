extends RefCounted
class_name DurabilityInstance

signal durability_changed(new_state: DurabilityDefinition.DurabilityStates)
signal item_destroyed

var definition: DurabilityDefinition

var _durability_state: DurabilityDefinition.DurabilityStates

var durability_state: DurabilityDefinition.DurabilityStates:
	get:
		return _durability_state
	set(value):
		set_durability_state(value)

func _init(def: DurabilityDefinition) -> void:
	definition = def
	_durability_state = def.initial_state

func set_durability_state(new_state: DurabilityDefinition.DurabilityStates) -> void:
	if _durability_state == new_state:
		return

	if _durability_state == DurabilityDefinition.DurabilityStates.DESTROYED:
		return

	var old_state := _durability_state
	_durability_state = new_state

	durability_changed.emit(new_state)

	if old_state != DurabilityDefinition.DurabilityStates.DESTROYED \
	and new_state == DurabilityDefinition.DurabilityStates.DESTROYED:
		item_destroyed.emit()

func is_intact() -> bool:
	return _durability_state == DurabilityDefinition.DurabilityStates.INTACT

func is_damaged() -> bool:
	return _durability_state == DurabilityDefinition.DurabilityStates.DAMAGED

func is_destroyed() -> bool:
	return _durability_state == DurabilityDefinition.DurabilityStates.DESTROYED
