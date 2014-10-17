require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
	# if the zip code is exactly five digits, assume that it is ok
	# if the zip code is more than 5 digits, truncate it to the first 5 digits
	# if the zip code is less than 5 digits, add zeros to the front until it becomes five digits

	##if zipcode.nil?
	##	"00000"
	##elsif zipcode.length < 5
	##	zipcode.rjust(5, "0")
	##elsif zipcode.length > 5
	##	zipcode[0..4]
	##else
	##	zipcode
	##end
	zipcode.to_s.rjust(5,"0")[0..4]
end

def legislator_by_zipcode(zipcode)
	##legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

	#legislator_names = []
	#legislators.each do |legislator|
	#	legislator_name = "#{legislator.first_name} #{legislator.last_name}"
	#	legislator_names.push legislator_name
	#end

	##legislator_names = legislators.collect do |legislator|
	##	"#{legislator.first_name} #{legislator.last_name}"
	##end

	##legislator_names.join(", ")
	Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
	Dir.mkdir("output") unless Dir.exists? "output"

	filename = "output/thanks_#{id}.html"

	File.open(filename, 'w') do |file|
		file.puts form_letter
	end
end

puts "EventManager initialized."

#####contents = CSV.open "event_attendees.csv", headers: true
contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|

#contents = File.read "event_attendees.csv"
#puts contents

####lines = File.readlines "event_attendees.csv"
##row_index = 0

###lines.each do |line|

####lines.each_with_index do |line, index|
	####next if index == 0

	##row_index += 1
	##next if row_index == 1

	#next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
	
	####columns = line.split(",")
	
	#####name = row[2]
	id = row[0]
	name = row[:first_name]
	zipcode = clean_zipcode(row[:zipcode])
	legislators = legislator_by_zipcode(zipcode)

	#personal_letter = template_letter.gsub('FIRST_NAME', name)
	#personal_letter.gsub!('LEGISLATORS', legislators)

	form_letter = erb_template.result(binding)

	save_thank_you_letters(id, form_letter)

	#puts "#{name} #{zipcode} #{legislators}"
	#puts personal_letter
	#puts form_letter
end
