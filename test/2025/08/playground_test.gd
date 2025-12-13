# GdUnit generated TestSuite
class_name PlaygroundTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source: String = 'res://src/2025/08/playground.gd'


func test_calc_part_one() -> void:
	var runner = scene_runner("res://src/2025/08/Playground.tscn")
	var data = runner.invoke("input", "example")
	var result = runner.invoke("calc_part_one", data, 10)
	assert_that(result).is_equal(40)

func test_calc_part_two() -> void:
	var runner = scene_runner("res://src/2025/08/Playground.tscn")
	var data = runner.invoke("input", "example")
	var result = runner.invoke("calc_part_two", data)
	assert_that(result).is_equal(25272)
