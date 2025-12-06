# GdUnit generated TestSuite
class_name GiftShopTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source: String = 'res://src/2025/02/gift_shop.gd'


#func test_input_example():
#	var runner = scene_runner("res://src/2025/02/GiftShop.tscn")
#	var data = runner.invoke("input", "example")
#	assert_that(data).is_equal(
#		[["11","22"],["95", "115"],["998","1012"],["1188511880","1188511890"],
#		["222220","222224"],["1698522","1698528"],["446443","446449"],
#		["38593856","38593862"],["565653","565659"],
#		["824824821","824824827"],["2121212118","2121212124"]])

func test_calc_part_one() -> void:
	var runner = scene_runner("res://src/2025/02/GiftShop.tscn")
	var data = runner.invoke("input", "example")
	var result = runner.invoke("calc_part_one", data)
	assert_that(result).is_equal(1227775554)
