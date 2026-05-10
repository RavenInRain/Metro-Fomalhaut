extends Control
class_name ItemView

# TODO: Consider creating the item card visuals via RENDERING SERVER.
# The idea is that I would make the layout inside a scene with Nodes,
#  and when I am satisfied, I would strip it to the RenderingServer method.
#var rid = RenderingServer.canvas_item_create()

@onready var name_label: Label = %NameLabel
@onready var damage_label: Label = %DamageLabel

var item: ItemRuntime

func bind(new_item: ItemRuntime) -> void:
	item = new_item
	refresh()

func refresh() -> void:
	name_label.text = item.definition.display_name
	damage_label.text = str(item.total_damage())
	print("bound name ", name_label, " to ", item.definition.display_name)
