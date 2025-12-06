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
	# remove this line and complete your test
	assert_not_yet_implemented()
