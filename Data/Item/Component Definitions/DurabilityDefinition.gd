extends Resource
class_name DurabilityDefinition

enum DurabilityStates {
	## State for mint or repaired items.
	INTACT,
	## State for used or exerted items.
	DAMAGED,
	## Not a real state, if the item ever reaches this, it is removed.
	DESTROYED,
}

@export var initial_state: DurabilityStates = DurabilityStates.INTACT
