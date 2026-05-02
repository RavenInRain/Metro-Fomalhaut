extends Control
class_name ItemCardCore

# TODO: Consider creating the item card visuals via RENDERING SERVER.
# The idea is that I would make the layout inside a scene with Nodes,
#  and when I am satisfied, I would strip it to the RenderingServer method.
var rid = RenderingServer.canvas_item_create()
var item: ItemRuntime

@onready var name_label: Label = %ItemName
@onready var damage_label: Label = %DamageLabel

func setup(runtime_item: ItemRuntime) -> void:
	item = runtime_item
	refresh()

func refresh() -> void:
	if item == null:
		name_label.text = "Empty"
		damage_label.text = ""
		return

	name_label.text = item.display_name()
	damage_label.text = "Damage: %d" % item.damage()
