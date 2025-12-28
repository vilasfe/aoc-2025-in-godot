extends RefCounted

class_name TreeArea

var size: Vector2i
var gifts: PackedInt64Array

func _init() -> void:
	size = Vector2i(0,0)
	gifts = []

func _to_string() -> String:
	return str(size) + str(gifts)
