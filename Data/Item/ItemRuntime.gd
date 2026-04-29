extends RefCounted
class_name ItemRuntime

var definition: ItemDefinition
var instance: ItemInstance

#-# APPLICATIONS
var application_mods: Dictionary[StringName, float] = {}

## Application Base in 0.5 increments.
func get_app_base(key: StringName) -> float:
	var app_def := definition.get_app(key)
	return app_def.base if app_def != null else 0.0

## Application temporary mod in 0.5 increments.
func get_app_mod(key: StringName) -> float:
	return application_mods.get(key, 0.0)

## Application Base + Mod.
func get_app_total(key: StringName) -> float:
	return get_app_base(key) + get_app_mod(key)

## Set app mod 
func set_app_mod(key: StringName, value: float) -> void:
	application_mods[key] = floor(value / 0.5) * 0.5

func reset_app_mod(key: StringName) -> void:
	application_mods.erase(key)
