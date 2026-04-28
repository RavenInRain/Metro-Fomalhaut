@tool
extends Resource
class_name ItemDefinition

@export var item_key: StringName
@export var display_name: String

@export var slots: SlotsDefinition
@export var durability: DurabilityDefinition

@export var woe: ApplicationDefinition
@export var ward: ApplicationDefinition
@export var point: ApplicationDefinition
@export var blast: ApplicationDefinition

@export var narrative: NarrativeDefinition

## Sets default Application Base values.
func _init() -> void:
	if woe == null:
		woe = _setup_app(0.5)

	if ward == null:
		ward = _setup_app(0.5)

	if point == null:
		point = _setup_app(0.0)

	if blast == null:
		blast = _setup_app(0.0)
		
	if narrative == null:
		narrative = NarrativeDefinition.new()
	
	if slots == null:
		slots = SlotsDefinition.new()
		
	if durability == null:
		durability = DurabilityDefinition.new()

#-# SETUP
func _setup_app(base: float) -> ApplicationDefinition:
	var app: ApplicationDefinition = ApplicationDefinition.new()
	app.base = base
	return app

#-# UTILITY
## Used in ItemData to fetch Application Base.
func get_app(key: StringName) -> ApplicationDefinition:
	match key:
		&"woe": return woe
		&"ward": return ward
		&"point": return point
		&"blast": return blast
		_:
			push_error("Invalid application key: %s" % key)
			return null
