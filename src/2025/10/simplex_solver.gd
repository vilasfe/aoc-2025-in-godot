extends RefCounted

class_name SimplexSolver

var _m: Matrix
var _augmented: Matrix
var _basis: Array[int]

func _init(m: Matrix) -> void:
	_m = m.clone()

# returns 2 element array of row,col
func _find_pivot() -> Array[int]:
	# find the most negative row-0 value NOT in
	# the basis and break ties randomly
	var min_0 = 999999999
	print(_basis)
	for c in _augmented.cols()-1:
		if ! _basis.has(c):
			min_0 = min(min_0, _augmented.cells.back()[c])

	var pivot_col_array: Array[int] = []
	for c in _augmented.cols()-1:
		if ! _basis.has(c) && is_equal_approx(_augmented.cells.back()[c], min_0):
			pivot_col_array.push_back(c)
	
	var pivot_col_idx = pivot_col_array[0] #.pick_random()
	var pivot_col = _augmented.col_slice([pivot_col_idx]).transpose().cells[0]
	var quotient_col = _augmented.col_slice([_augmented.cols()-1]).transpose().cells.back()
	for q in quotient_col.size():
		quotient_col[q] /= 1.0 * pivot_col[q]
	print(quotient_col)
	var min_col = 99999999
	var pivot_row_idx = -1
	for q in quotient_col.size():
		if quotient_col[q] > 0 && quotient_col[q] < min_col:
			min_col = quotient_col[q]
			pivot_row_idx = q
	return [pivot_row_idx, pivot_col_idx]

# Assumes that objective function is already
# encoded as row-0 in the input matrix
func solve() -> Array:
	# find initial basic feasible solution by adding an
	# artificial variable for each constraint and a
	# big-M coefficient to the objective function
	var id: Matrix = Matrix.identity(_m.rows())

	var col_range: Array[int]
	col_range.assign(range(0, _m.cols()-2))
	_augmented = _m.col_slice(col_range)
	col_range.assign(range(0, id.cols()-1))
	_augmented = _augmented.append_right(id.col_slice(col_range)).append_right(_m.col_slice([_m.cols()-2, _m.cols()-1]))
	# Put the augmented artificial vars in the basis
	# and let the goal variables be 0
	var big_m = 2.0 * _augmented.col_sum([_augmented.cols()-1])[0]
	for i in range(_m.cols()-2, _augmented.cols()-2):
		_augmented.cells.back()[i] = big_m
	print(_augmented)
	# For each artificial variable, we need to
	# substitute it out of the objective function
	for r in range(0, _augmented.rows()-1):
		for c in _augmented.cols():
			_augmented.cells[r][c] *= -big_m
			_augmented.cells.back()[c] += _augmented.cells[r][c]
	print("Starting augmented matrix")
	print(_augmented)

	# Setup basis as objective function and all artificial variables
	_basis.assign(range(_m.cols()-2, _augmented.cols()-1))

	# while non-recurring pivot found
	var seen: Array[Array] = []
	var non_neg_non_basis: bool = true
	while non_neg_non_basis:
		# find pivot cell
		var pivot = _find_pivot()
		print(pivot)
		if pivot in seen:
			print("Exiting due to revisiting a vertex")
			break
		seen.append(pivot)
		
		# get the cell at the pivot row,col to be 1
		var pivot_factor = 1.0 / _augmented.cells[pivot[0]][pivot[1]]
		for c in _augmented.cols():
			_augmented.cells[pivot[0]][c] *= pivot_factor
		
		# annoyingly multiply and add to zero out other
		# rows in the pivot column
		for r in _augmented.rows():
			if r != pivot[0]:
				var factor: float = -_augmented.cells[r][pivot[1]] / _augmented.cells[pivot[0]][pivot[1]]
				#print("factor: " + str(factor))
				for c in _augmented.cols():
					_augmented.cells[r][c] += factor * _augmented.cells[pivot[0]][c]
		print("Updated augmented matrix")
		print(_augmented)
		
		# Update the basis
		_basis[pivot[0]] = pivot[1]
		
		# Check for being solved
		non_neg_non_basis = false
		for c in _augmented.cols()-1:
			if ! _basis.has(c) && _augmented.cells.back()[c] <= 0:
				non_neg_non_basis = true
		if ! non_neg_non_basis:
			print("Exiting due to non-negative values on all basis variables")

	# return the answer
	print(_basis)
	var to_return = _augmented.col_slice([_augmented.cols()-1]).transpose().cells[0].duplicate()
	to_return = to_return.slice(0, to_return.size()-1)
	return to_return
