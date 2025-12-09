@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()


static func input(fname: String) -> Array:
	var content = Utils.file_lines(str("res://src/2025/07/", fname, ".txt"))
	return content

func calc_part_one(data: PackedStringArray) -> int:
	var splits: int = 0
	var beam_map: PackedStringArray = []
	beam_map.append(data[0])
	for d in data.slice(1):
		# propagate all the beams that do not split
		var next_row: String = d
		for c in range(d.length()):
			if beam_map[beam_map.size()-1][c] in "|S" && next_row[c] != '^':
				next_row[c] = '|'
		# now do a second pass for the splitters so we can count thte splits
		for c in range(d.length()):
			if beam_map[beam_map.size()-1][c] in "|S" && next_row[c] == '^':
				next_row[c-1] = '|'
				next_row[c+1] = '|'
				splits += 1
		beam_map.append(next_row)
	return splits

func calc_part_two(data: PackedStringArray) -> int:
	return 0

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	return calc_part_two(data)
