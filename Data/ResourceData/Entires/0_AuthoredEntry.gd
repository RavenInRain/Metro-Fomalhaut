extends Resource
class_name AuthoredEntry

@export var entry_id: String = ""

func ensure_entry_id(entry_key: String) -> void:
	if entry_id == "":
		entry_id = IDHelper.gen_entry_id(entry_key)
