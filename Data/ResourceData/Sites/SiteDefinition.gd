@tool
extends Resource
class_name SiteDefinition

## Containers exist in Sites and Pawns.
@export var site_key: StringName
@export var container_entries: Array[SiteContainerEntry]

## Each Site has a default variant which is responsible for the contents of the Site.
@export var default_variant: SiteVariantDefinition = SiteVariantDefinition.new()
@export var site_variants: Array[SiteVariantDefinition] = []

func ensure_default_variant() -> void:
	if default_variant == null:
		default_variant = SiteVariantDefinition.new()
		default_variant.variant_key = &"default"
		default_variant.site_display_name = "Default Site"
		emit_changed()
