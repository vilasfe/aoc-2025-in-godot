@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()


static func input(fname: String) -> Array:
	var content = Utils.file_lines(str("res://src/2025/03/", fname, ".txt"))
	return content

func calc_part_one(data: PackedStringArray) -> int:
	var joltage: int = 0
	for d in data:
		var battery_array = Array(d.split()).map(func(e: String) -> int: return int(e))
		var max_light = battery_array.slice(0,-1).max()
		var max_light_index = battery_array.find(max_light)
		var min_light = battery_array.slice(max_light_index+1).max()
		joltage += max_light * 10 + min_light
	return joltage

func calc_part_two(data: PackedStringArray) -> int:
	return 0

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
