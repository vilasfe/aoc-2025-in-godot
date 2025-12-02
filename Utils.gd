@tool
extends Node
class_name Utils

static func file_content(fpath) -> String:
	if not FileAccess.file_exists(fpath):
		#Log.warn("file does not exist", fpath)
		return ""

	var file = FileAccess.open(fpath, FileAccess.READ)
	var content = file.get_as_text()

	return content

static func file_lines(fpath) -> PackedStringArray:
	var content = file_content(fpath)

	return content.split("\n", false)
