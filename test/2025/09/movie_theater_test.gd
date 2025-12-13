# GdUnit generated TestSuite
class_name MovieTheaterTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source: String = 'res://src/2025/09/movie_theater.gd'


func test_calc_part_one() -> void:
	var runner = scene_runner("res://src/2025/09/MovieTheater.tscn")
	var data = runner.invoke("input", "example")
	var result = runner.invoke("calc_part_one", data)
	assert_that(result).is_equal(50)
