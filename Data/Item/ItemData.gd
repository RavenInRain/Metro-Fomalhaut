extends RefCounted
class_name ItemData

@export var item_id: String = ""
@export var definition: ItemDefinition

const APP_WOE: StringName = &"woe"
const APP_WARD: StringName = &"ward"
const APP_POINT: StringName = &"point"
const APP_BLAST: StringName = &"blast"

#-# STATES
var durability: DurabilityState
var applications: Dictionary[StringName, ApplicationState] = {}

func _init(def: ItemDefinition) -> void:
	setup_from_definition(definition)

	applications[APP_WOE] = ApplicationState.new(def.woe)
	applications[APP_WARD] = ApplicationState.new(def.ward)
	applications[APP_POINT] = ApplicationState.new(def.point)
	applications[APP_BLAST] = ApplicationState.new(def.blast)
	
	if def.durability != null:
		durability = DurabilityState.new(def.durability)
		durability.item_destroyed.connect(_on_item_destroyed)

func setup_from_definition(def: ItemDefinition) -> void:
	definition = def

#-# APPLICATION FUNCTION
func get_app(key: StringName) -> ApplicationState:
	if not applications.has(key):
		push_error("Invalid application key: %s" % key)
		return null

	return applications[key]

func get_app_base(key: StringName) -> float:
	var def: ApplicationDefinition = definition.get_app(key)
	return def.base if def != null else 0.0

func get_app_mod(key: StringName) -> float:
	var app: ApplicationState = get_app(key)
	return app.mod if app != null else 0.0

func get_app_total(key: StringName) -> float:
	var app: ApplicationState = get_app(key)
	return app.get_total() if app != null else 0.0

func reset_app_mod(key: StringName) -> void:
	var app: ApplicationState = get_app(key)
	if app != null:
		app.reset_mod()

#-# DURABILITY FUNCTION
func damage_item() -> void:
	durability.set_durability_state(DurabilityDefinition.DurabilityStates.DAMAGED)

func destroy_item() -> void:
	durability.set_durability_state(DurabilityDefinition.DurabilityStates.DESTROYED)

func _on_item_destroyed() -> void:
	print("Item destroyed: ", definition.item_key)
