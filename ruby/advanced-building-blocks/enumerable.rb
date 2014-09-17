module Enumerable
	def my_each
		if block_given?
			for element in self
				yield(element)
			end
		else
			self
		end
	end

	def my_each_with_index
		if block_given?
			for i in 0...self.length
				yield(self[i], i)
			end
		else
			self
		end
	end

	def my_select
		if block_given?
			result_array = []
			self.my_each {|i| result_array << i if yield(i)}
			result_array
		else
			self
		end
	end

	def my_all?
		if block_given?
			self.my_each {|i| return false unless yield(i)}
		else
			self.my_each {|i| return false unless i}
		end
		true
	end

	def my_any?
		if block_given?
			self.my_each {|i| return true if yield(i)}
		else
			self.my_each {|i| return true if i}
		end
		false
	end

	def my_none?
		if block_given?
			self.my_each {|i| return false if yield(i)}
		else
			self.my_each {|i| return false if i}
		end
		true
	end

	def my_count(num=nil)
		c = 0
		if block_given?
			self.my_each {|i| c+=1 if yield(i)}
		elsif num.nil?
			c = self.length
		else
			my_each {|i| c+=1 if i == num}
		end
		c
	end

	def my_map(&block)
		map = []
		if block_given?
			for i in self
				map << block.call(i)
			end
			map
		else
			self
		end
	end

	def my_inject(n=nil)
		memo = n == nil ? self.first : n
		m = n == nil ? self.my_count - 1 : self.my_count
		for i in self.last(m)
			memo = yield(memo, i)
		end
		memo
	end
end

def multiply_els(array)
	array.my_inject{ |memo,n| memo * n}
end
end