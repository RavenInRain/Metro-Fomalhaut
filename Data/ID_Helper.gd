extends RefCounted
class_name IDHelper

static var alphabet: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

static func _ready() -> void:
	randomize()

static func get_random_letter() -> String: 
	return alphabet[randi() % alphabet.length()]
