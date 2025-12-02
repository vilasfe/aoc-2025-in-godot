# GdUnit generated TestSuite
class_name SecretEntranceTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source: String = 'res://src/2025/01/secret_entrance.gd'

func test_input_example():
	var runner = scene_runner("res://src/2025/01/SecretEntrance.tscn")
	var data = runner.invoke("input", "example")
	assert_that(data).is_equal(["L68","L30","R48","L5","R60","L55","L1","L99","R14","L82"])

func test_calc_part_one() -> void:
	var runner = scene_runner("res://src/2025/01/SecretEntrance.tscn")
	var data = runner.invoke("input", "example")
	var result = runner.invoke("calc_part_one", data)
	assert_that(result.get("zero_count")).is_equal(3)
	assert_that(result.get("zero_cross")).is_equal(6)
