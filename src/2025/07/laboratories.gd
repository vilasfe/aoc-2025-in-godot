@tool
extends Node

@export var light_segment_scene: PackedScene

@onready var beam_map: Array[PackedInt64Array] = []

func _ready():
	if Engine.is_editor_hint():
		request_ready()
	light_segment_scene = preload("res://src/2025/07/LightSegment.tscn")

func launch_gui():
	for child in get_children():
		child.show()
	var data = input("input")
	var y_start = 0
	calc_part_two(data)
	#print(data.size())
	#print(data[0].length())
	#print(get_parent().size)
	#print(get_parent().size.y / data.size())
	#print(get_parent().size.x / data[0].length())
	var node_scale: Vector2 = Vector2(0.10,0.10)
	for d in data.size():
		var x_start = 0
		for c in data[d].length():
			var n = light_segment_scene.instantiate() as LightSegment
			add_child(n)
			n.apply_scale(node_scale)
			n.set_position(Vector2(x_start, y_start))
			if data[d][c] == 'S':
				n.set_color(Color.GREEN)
			elif data[d][c] == '^':
				n.set_color(Color.BLUE)
			elif beam_map[d][c] > 0:
				n.set_timelines(beam_map[d][c])
			x_start += 41 * node_scale.x
			continue
		var sum = light_segment_scene.instantiate() as LightSegment
		add_child(sum)
		sum.set_position(Vector2(get_parent().size.x - 42, y_start))
		var total = Array(beam_map[d]).reduce(func(accum: int, e: int) -> int: return accum + e, 0)
		sum.set_timelines(total)
		y_start += 41 * node_scale.y


static func input(fname: String) -> Array:
	var content = Utils.file_lines(str("res://src/2025/07/", fname, ".txt"))
	return content

func calc_part_one(data: PackedStringArray) -> int:
	var splits: int = 0
	var str_beam_map: PackedStringArray = []
	str_beam_map.append(data[0])
	for d in data.slice(1):
		# propagate all the beams that do not split
		var next_row: String = d
		for c in range(d.length()):
			if str_beam_map[str_beam_map.size()-1][c] in "|S" && next_row[c] != '^':
				next_row[c] = '|'
		# now do a second pass for the splitters so we can count thte splits
		for c in range(d.length()):
			if str_beam_map[str_beam_map.size()-1][c] in "|S" && next_row[c] == '^':
				next_row[c-1] = '|'
				next_row[c+1] = '|'
				splits += 1
		str_beam_map.append(next_row)
	return splits

func calc_part_two(data: PackedStringArray) -> int:
	beam_map = []
	beam_map.push_back(PackedInt64Array())
	beam_map[0].resize(data[0].length())
	beam_map[0].fill(0)
	beam_map[0][data[0].find("S")] = 1
	
	for d in data.slice(1):
		# propagate all the beams that do not split
		var next_row: PackedInt64Array = []
		next_row.resize(d.length())
		next_row.fill(0)
		for c in range(d.length()):
			if beam_map.back()[c] > 0 && d[c] != '^':
				next_row[c] += beam_map.back()[c]
		# now do a second pass for the splitters so we can count thte splits
		for c in range(d.length()):
			if beam_map.back()[c] > 0 && d[c] == '^':
				next_row[c-1] += beam_map.back()[c]
				next_row[c+1] += beam_map.back()[c]
		beam_map.append(next_row)
	return Array(beam_map.back()).reduce(func(accum: int, e: int) -> int: return accum + e, 0)

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data)

func run_part_two() -> int:
	var data = input("input")
	# 29822800930 is too low
	return calc_part_two(data)
