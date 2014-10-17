def merge(arr_a, arr_b, result_arr=[])
	return result_arr.concat(arr_b) if arr_a.empty?
	return result_arr.concat(arr_a) if arr_b.empty?

	result_arr << (arr_a[0] < arr_b[0] ? arr_a.slice!(0) : arr_b.slice!(0))
	merge(arr_a, arr_b, result_arr)
end

def merge_sort(arr)
	result = []
	return arr if arr.size <= 1

	left, right = arr[0...arr.length/2], arr[arr.length/2..-1]

	left = merge_sort(left)
	right = merge_sort(right)

	result = merge(left, right)
end

puts merge_sort([50, 108, 23, 15, 4, 42, 16, 8]).join(", ")
puts merge_sort([50, 108, 23, 69, 15, 4, 42, 16, 8]).join(", ")