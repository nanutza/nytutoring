require 'open-uri'
require 'json'
require 'pry'

module GoogleApiParser


	def self.run(address)
	geocode_url = self.geocode_query(address)
	uri = URI.parse(URI.encode(geocode_url.strip))
	# binding.pry
  	geocode_hash = self.geocode_get_json(uri)
  	nearby_url = self.lat_long_finder(geocode_hash)
	nearby_uri = URI.parse(URI.encode(nearby_url.strip))

  	end

	def self.geocode_query(address)
		"https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=AIzaSyCZOBiuZbRMYQ1T_fX6G-ilaRQ5zsAlE1s"
	end

	def self.geocode_get_json(geocode_url)
		JSON.parse(open(geocode_url).read)
	end

	def self.lat_long_finder(geocode_hash)
		lat_long_hash = geocode_hash["results"][0]["geometry"]["location"]
		lat = lat_long_hash["lat"]
		lng = lat_long_hash["lng"]
    puts "The latitude is #{lat}"
    puts "The longitude is #{lng}"
		"https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyCZOBiuZbRMYQ1T_fX6G-ilaRQ5zsAlE1s&location=#{lat},#{lng}&radius=1000&type=park"
	end


	# def self.nearby_query(nearby_url)
	# 	JSON.parse(open(nearby_url).read)
	# end

	def self.park_list(nearby_hash)
		nearby_hash["results"].map { |place| place["name"] }
	end



end

# test driver code

geocode_url = GoogleApiParser.geocode_query("48 Wall Street, NY")

geocode_hash = GoogleApiParser.geocode_get_json(geocode_url)

# geocode_hash["results"][0]["geometry"]["location"] # {"lat"=>40.09864, "lng"=> -74.097}

nearby_url = GoogleApiParser.lat_long_finder(geocode_hash)
