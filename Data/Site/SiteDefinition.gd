extends Resource
class_name SiteDefinition

#-# SITE NAME
var site_key: StringName
var display_name: String

#-# SITE FEATURES
var site_paths: Dictionary[StringName, SiteRuntime]
var site_landmarks: Array

#-# SITE VARIANTS
var site_variants: Dictionary[StringName, SiteDefinition]
