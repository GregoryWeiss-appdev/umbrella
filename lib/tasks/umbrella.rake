task(:umbrella) do
  geocoding_url = "https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=AIzaSyDB6uZXmYRlo88RLhAxD-yxUbMIZd4oHpg"
  weather_url = "https://api.darksky.net/forecast/26f63e92c5006b5c493906e7953da893/41.8887,-87.6355"
  weather_raw_file = open(weather_url).read
  weather_parsed_file = JSON.parse(weather_raw_file)
  ap weather_parsed_file.keys
  currently = weather_parsed_file.fetch("currently")
  ap currently.fetch("temperature")
end