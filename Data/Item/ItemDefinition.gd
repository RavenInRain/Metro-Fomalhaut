@tool
extends Resource
class_name ItemDefinition

@export var item_key: StringName
@export var display_name: String

@export var slots: SlotsDefinition
@export var durability: DurabilityDefinition

## Item's capacity to Destroy/Harm. 
## Used in the Attack Action.
@export var woe: ApplicationDefinition

## Item's capacity to Shield/Obscure. 
## Used in the Defend Action and Interpose.
@export var ward: ApplicationDefinition

## Item's capacity to be used at range and it's precision.
## Used in Actions against adjacent Tiles.
@export var point: ApplicationDefinition

## Item's capacity to be used on multiple targets.
## Used in Actions against multiple targets in the same tile.
## If the Item also has Point - Blast ignores Allignment.
@export var blast: ApplicationDefinition

@export var application_test: TestDefinition

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
## Used in ItemRuntime to fetch Application Base.
func get_app(key: StringName) -> ApplicationDefinition:
	match key:
		&"woe": return woe
		&"ward": return ward
		&"point": return point
		&"blast": return blast
		_:
			push_error("Invalid application key: %s" % key)
			return null
