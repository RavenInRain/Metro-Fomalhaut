extends Node2D

@onready var ui: UIManager = %UI
@export var site_view_scene: PackedScene
@onready var bodyview : Control =  %C_Spot_1

var loaded_sites: Array[SiteRuntime] = []

func _ready() -> void:
	start_game()

func start_game() -> void:
	SaveLoadManager.load_game()

	load_site("uid://br4iab62rnsso")
	
func load_site(site_uid: String) -> void:
	var site_def := load(site_uid) as SiteDefinition

	if site_def == null:
		push_error("Failed to load SiteDefinition: %s" % site_uid)
		return

	var site_runtime := AuthoredContentBuilder.build_site(site_def)

	loaded_sites.append(site_runtime)

	create_site_view(site_runtime)
	
func create_site_view(site_runtime: SiteRuntime) -> void:
	var site_view := site_view_scene.instantiate()

	bodyview.add_child(site_view)

	site_view.bind(site_runtime)
