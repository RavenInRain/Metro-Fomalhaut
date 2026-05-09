extends CanvasLayer
class_name UIManager

signal instance_requested
signal build_site_requested

func _on_save_game() -> void:
	SaveLoadManager.save_game()

func _on_load_game() -> void:
	SaveLoadManager.load_game()

func _on_build_site() -> void:
	build_site_requested.emit()

func _on_instance_scene() -> void:
	instance_requested.emit()
