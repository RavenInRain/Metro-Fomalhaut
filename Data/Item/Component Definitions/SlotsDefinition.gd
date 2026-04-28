extends Resource
class_name SlotsDefinition

signal slots_changed

@export var slots: int = 1

func change_slots(amount: int) -> void:
	slots += amount
	slots_changed.emit()
