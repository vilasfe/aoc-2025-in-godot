extends RefCounted

class_name Matrix

var cells: Array[Array] = []

func _init(row_count: int, col_count: int, default: Variant = 0) -> void:
	cells.resize(row_count)
	var r_tmp = []
	r_tmp.resize(col_count)
	r_tmp.fill(default)
	for r in cells.size():
		cells[r] = r_tmp.duplicate()

func _to_string() -> String:
	var to_return: String = "[" + str(cells[0])
	for r in cells.slice(1):
		to_return += ",\n " + str(r)
	to_return += "]"
	return to_return

func clone() -> Matrix:
	var to_return = Matrix.new(rows(), cols(), cells[0][0])
	for r in rows():
		for c in cols():
			# Note this will shallow copy for some types
			to_return.cells[r][c] = cells[r][c]
	return to_return

func rows() -> int:
	return cells.size()

func cols() -> int:
	return cells[0].size()

static func identity(size: int) -> Matrix:
	var to_return = Matrix.new(size, size, 0)
	for s in size:
		to_return.cells[s][s] = 1
	return to_return

func col_slice(col_idx: Array[int]) -> Matrix:
	var to_return = Matrix.new(rows(), col_idx.size(), cells[0][0])
	for r in rows():
		for c in col_idx.size():
			to_return.cells[r][c] = cells[r][col_idx[c]]
	return to_return

func col_sum(col_idx: Array[int]) -> Array[float]:
	var to_return: Array[float] = []
	for c in col_idx:
		var col_sum: float = 0.0
		for r in rows():
			col_sum += cells[r][c]
		to_return.push_back(col_sum)
	return to_return

func append_right(m2: Matrix) -> Matrix:
	var to_return = Matrix.new(rows(), cols() + m2.cols(), cells[0][0])
	for r in rows():
		for c in cols():
			to_return.cells[r][c] = cells[r][c]
		for c in m2.cols():
			to_return.cells[r][c + cols()] = m2.cells[r][c]
	return to_return

func transpose() -> Matrix:
	var to_return = Matrix.new(cols(), rows(), cells[0][0])
	for r in rows():
		for c in cols():
			to_return.cells[c][r] = cells[r][c]
	return to_return
