extends RefCounted
class_name IDHelper

static var alphabet: String = "abcdefghijklmnopqrstuvwxyz"

static func _ready() -> void:
	randomize()

static func get_random_letter() -> String: 
	return alphabet[randi() % alphabet.length()]

static func gen_resource_id(res_key: StringName) -> String:
	return "%s_%s%d" % [
		String(res_key),
		get_random_letter(),
		randi() % 1000000
	]
