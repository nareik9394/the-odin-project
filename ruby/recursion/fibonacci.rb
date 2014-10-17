def fibs(n)
	return 0 if n == 0

	num = 0
	next_num = 1
	temp = 0

	while (n -= 1) > 0 do 
		temp = num + next_num
		num = next_num
		next_num = temp
	end

	return next_num
end

def fibs_rec(n)
	return n if n <= 1

	fibs_rec(n-1) + fibs_rec(n-2)
end