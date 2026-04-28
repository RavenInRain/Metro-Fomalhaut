extends Resource
class_name DurabilityDefinition

enum DurabilityStates {
	INTACT,
	DAMAGED,
	DESTROYED,
}

@export var initial_state: DurabilityStates = DurabilityStates.INTACT
