@tool
extends Node2D

func _ready():
	if Engine.is_editor_hint():
		request_ready()

	# var invs = elf_inventories()
	# print(invs)
	# var largest = largest_inventory(invs, 3)
	# print(largest)

func run_part_one() -> int:
	return 0

func run_part_two() -> int:
	return 0
