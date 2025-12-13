extends Control

@onready var day_loader = $DayLoader
var day_label
var day_container
var part_one_result
var part_two_result

var current

func _ready():
	day_label = get_node("%DayLabel")
	day_container = get_node("%DayContainer")
	part_one_result = get_node("%PartOneResult")
	part_two_result = get_node("%PartTwoResult")

	for p in scenes:
		var tmp = p.instantiate()
		day_loader.add_item(tmp.name)

func _on_DaySelector_pressed():
	day_loader.popup_centered_ratio()


func _on_DayLoader_id_pressed(id:int):
	var s = scenes[id]
	current = s.instantiate()
	day_label.text = current.name

	for c in day_container.get_children():
		c.queue_free()

	day_container.add_child(current)

	part_one_result.text = ""
	part_two_result.text = ""

# TODO: Change this from preload to autodiscovery
var scenes = [
	preload("res://src/2025/01/SecretEntrance.tscn"),
	preload("res://src/2025/02/GiftShop.tscn"),
	preload("res://src/2025/03/Lobby.tscn"),
	preload("res://src/2025/04/PrintingDepartment.tscn"),
	preload("res://src/2025/05/Cafeteria.tscn"),
	preload("res://src/2025/06/TrashCompactor.tscn"),
	preload("res://src/2025/07/Laboratories.tscn"),
	preload("res://src/2025/08/Playground.tscn"),
	preload("res://src/2025/09/MovieTheater.tscn")
	]

func _on_PartOne_pressed():
	if not current:
		print("no current, please select a day first")
		return

	if current.has_method("run_part_one"):
		var result = current.run_part_one()
		part_one_result.text = str(result)
	else:
		print("No run_part_one method on current scene")

func _on_PartTwo_pressed():
	if not current:
		print("no current, please select a day first")
		return

	if current.has_method("run_part_two"):
		var result = current.run_part_two()
		part_two_result.text = str(result)
	else:
		print("No run_part_two method on current scene")
