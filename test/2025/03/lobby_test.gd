# GdUnit generated TestSuite
class_name LobbyTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source: String = 'res://src/2025/03/lobby.gd'


func test_calc_part_one() -> void:
	var runner = scene_runner("res://src/2025/03/Lobby.tscn")
	var data = runner.invoke("input", "example")
	var result = runner.invoke("calc_part_one", data)
	assert_that(result).is_equal(357)

func test_run_part_two() -> void:
	var runner = scene_runner("res://src/2025/03/Lobby.tscn")
	var data = runner.invoke("input", "example")
	var result = runner.invoke("calc_part_two", data)
	assert_that(runner.invoke("calc_part_two", [["987654321111111"]])).is_equal(987654321111)
	assert_that(runner.invoke("calc_part_two", [["811111111111119"]])).is_equal(811111111119)
	assert_that(runner.invoke("calc_part_two", [["234234234234278"]])).is_equal(434234234278)
	assert_that(runner.invoke("calc_part_two", [["818181911112111"]])).is_equal(888911112111)
	assert_that(result).is_equal(3121910778619)
