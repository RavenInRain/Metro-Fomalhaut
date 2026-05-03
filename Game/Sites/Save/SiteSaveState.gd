extends Resource
class_name SiteSaveState

@export var site_key: StringName
@export var active_variant_key: StringName = &"default"
@export var applied_variant_keys: Array[StringName] = []
