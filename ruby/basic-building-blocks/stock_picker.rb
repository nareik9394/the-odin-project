def stock_picker(stock_prices)
	best_pair = Array.new(2)

	lowest_value = stock_prices.min
	best_buy_day = stock_prices.index(lowest_value)
	highest_value = stock_prices.max
	best_sell_day = stock_prices.index(highest_value)

	#worse case
	if best_buy_day > best_sell_day
		sample_length = stock_prices.length
		max_profit = 0
		buy_day = 0

		while buy_day < sample_length
			buy_value = stock_prices[buy_day]
			sell_day = buy_day + 1
			while sell_day < sample_length
				sell_value = stock_prices[sell_day]
				p_and_l = sell_value - buy_value

				if(p_and_l > max_profit)
					max_profit = p_and_l
					best_buy_day = buy_day
					best_sell_day = sell_day
				end
				sell_day += 1
			end
			buy_day += 1
		end
	end
	
	best_pair << best_buy_day << best_sell_day

	return best_pair
end

stock1 = [17,3,6,9,15,8,6,1,10]
puts stock_picker(stock1)