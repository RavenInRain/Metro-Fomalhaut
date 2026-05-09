extends Node2D

@onready var ui: UIManager = %UI

func _ready() -> void:
	ui.build_site_requested.connect(build_site)
	SaveLoadManager.load_game()

func build_site() -> void:
	var site_def: SiteDefinition = load("uid://br4iab62rnsso") as SiteDefinition
	var site_runtime: SiteRuntime = AuthoredContentBuilder.build_site(site_def)
	
	ContentDebug.debug_print_site(site_runtime)
	
	
