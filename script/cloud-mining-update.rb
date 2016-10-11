require 'json'
require 'date'

file = File.read('_data/cloud-mining.json')
sites = JSON.parse(file)

sites.each do |s|
	date1 = Date.parse(s["signup"])
	date2 = Date.parse(s["update"])

	minSat = s["minimum-pay"] * 100000000
	days = (date2 - date1).to_i

	puts minSat
	if (minSat > 0 && days > 0) 
		expected = minSat / (s["total"] / days)
		puts expected
		s["expected"] = expected.to_i

	else 
		s["expected"] = "??"
	end

	s["days"] = days;

end

File.open('_data/cloud-mining.json',"w") do |f|
  f.write(JSON.pretty_generate(sites))
end