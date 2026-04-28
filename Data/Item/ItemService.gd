extends Node
class_name ItemService

@onready var item_database: ItemDatabase = %Item_Database

var item_index: int = 0

func _ready() -> void:
	#ui.item_from_key_requested.connect(create_and_output)
	pass

static func create_and_output(item_def: ItemDefinition) -> ItemData:
	if item_def == null:
		return

	var item: ItemData = ItemData.new(item_def)
	item.setup_from_definition(item_def)
	print(item.get_app_base(&"woe"))
	return item
