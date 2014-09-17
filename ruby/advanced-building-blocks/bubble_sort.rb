def bubble_sort(input_array)
	action_count = 0
	first_loop = true
	compare_length = input_array.length - 1

	while action_count > 0 || first_loop
		action_count = 0
		first_loop = false
		index = 0

		while index < compare_length
			left = input_array[index]
			right = input_array[index+1]

			if (left <=> right) == 1
				input_array[index], input_array[index+1] = right, left
				action_count += 1
			end

			index += 1
		end

		compare_length -= 1
	end

	return input_array
end

def bubble_sort_by(input_array)
	action_count = 0
	first_loop = true
	compare_length = input_array.length - 1

	while action_count > 0 || first_loop
		action_count = 0
		first_loop = false
		index = 0

		while index < compare_length
			left = input_array[index]
			right = input_array[index+1]

			block_result = yield(left, right)

			if block_result < 0
				input_array[index], input_array[index+1] = right, left
				action_count += 1
			end

			index += 1
		end

		compare_length -= 1
	end

	puts input_array
end

array = [4,3,78,2,0,2]
puts bubble_sort(array)

bubble_sort_by(["hi","hello","hey"]) do |left, right|
	right.length - left.length
end
