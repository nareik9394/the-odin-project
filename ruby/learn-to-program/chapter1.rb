days_in_year = 365
hours_in_day = 24
minutes_in_hour = 60
seconds_in_minute = 60

puts "Q1: How many hours are in a year?"
puts days_in_year * hours_in_day
puts ""

puts "Q2: How many minutes are in a decade?"
puts 10 * days_in_year * hours_in_day * minutes_in_hour
puts ""

age_to_date = (Time.new).to_i
seconds_old = age_to_date - (Time.new(1990, 7, 19, 16)).to_i

puts "Q3: How many seconds old are you?"
puts seconds_old
puts ""

million = 1000000
seconds_old = 1031 * million

puts "Q4: If I am 1031 million seconds old, how old am I?"
puts seconds_old / seconds_in_minute / minutes_in_hour / hours_in_day / days_in_year
puts ""