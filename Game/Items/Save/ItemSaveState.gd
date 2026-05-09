extends Resource
## Template for savable data and is the default save config of items.
class_name ItemSaveState

#-# IDENTITY
@export var item_key: StringName
@export var instance_id: String

#-# PATH
@export var origin_path: String
@export var current_location_path: String

#-# PROPERTIES
@export var durability: int = 5
