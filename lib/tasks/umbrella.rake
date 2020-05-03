task(:umbrella) do
  user_location = "Merchandise Mart"
  geocoding_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GEOCODING_API_KEY")

  address_raw_file = open(geocoding_url).read
  p address_raw_file

  latitude = "X"
  longitude = "Y"
  weather_url = "https://api.darksky.net/forecast/" + ENV.fetch("DARKSKY_API_KEY") + "/41.8887,-87.6355"
  weather_raw_file = open(weather_url).read
  weather_parsed_file = JSON.parse(weather_raw_file)
  ap weather_parsed_file.keys
  currently = weather_parsed_file.fetch("currently")
  ap currently.fetch("temperature")
end