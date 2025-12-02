@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()


static func input(fname: String) -> PackedStringArray:
	var content = Utils.file_lines(str("res://src/2025/01/", fname, ".txt"))
	return content

func calc_part_one(data: PackedStringArray) -> Dictionary:
	var zero_count: int = 0
	var zero_cross: int = 0
	var current_val: int = 50
	for d in data:
		# print("Starting loop: current_val %d" % current_val)
		var lr: int = 1
		if d.substr(0,1) == "L":
			lr = -1
		var mag: int = int(d.substr(1))
		# print("d: %s, lr: %d, mag: %d" % [d, lr, mag])

		var complete_rotations: int = abs(mag) / 100
		mag = mag % 100
		zero_cross += complete_rotations

		if mag != 0:
			var new_val: int = current_val + lr * mag
			if current_val != 0 && (new_val <= 0 || new_val > 99):
				zero_cross += 1

			# modulo math isn't behaving here and
			# there is at most one wrap so do it manually
			if new_val < 0:
				current_val = new_val + 100
			elif new_val > 99:
				current_val = new_val - 100
			else:
				current_val = new_val

		if current_val == 0:
			zero_count += 1

	return {"zero_count": zero_count, "zero_cross": zero_cross}

func run_part_one() -> int:
	var data = input("input")
	return calc_part_one(data).get("zero_count")

func run_part_two() -> int:
	var data = input("input")
	return calc_part_one(data).get("zero_cross")
