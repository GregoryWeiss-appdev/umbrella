task(:umbrella) do
  user_location = "1 VANDYKE ST, DEWEY BEACH, DE"
  geocoding_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GEOCODING_API_KEY")

  address_raw_file = open(geocoding_url).read
  address_parsed_file = JSON.parse(address_raw_file)
  results = address_parsed_file.fetch("results")[0]
  geometry = results.fetch("geometry")
  location = geometry.fetch("location")
  latitude_float = location.fetch("lat")
  longitude_float = location.fetch("lng")
  latitude = latitude_float.to_s
  longitude = longitude_float.to_s

  weather_url = "https://api.darksky.net/forecast/" + ENV.fetch("DARKSKY_API_KEY") + "/" + latitude + "," + longitude
  weather_raw_file = open(weather_url).read
  weather_parsed_file = JSON.parse(weather_raw_file)
  
  #print the current temperature
  currently = weather_parsed_file.fetch("currently")
  current_temperature = currently.fetch("temperature")
  p "The current temperature is " + current_temperature.to_s + " degrees Fahrenheit."
  
  #print the outlook for the next hour
  hourly = weather_parsed_file.fetch("hourly")
  hourly_data = hourly.fetch("data")
  
  next_hour_time = hourly_data[0].fetch("time")
  next_hour_summary = hourly_data[0].fetch("summary")
  p "Over the next hour the weather outlook is: " + next_hour_summary + "."


  #print whether someone should carry an umbrella
  #Someone should carry an umbrella if there is a >50% chance of precipitation at any point during the next 12 hours
  tracker = 0
  rain_chance_over_50_indicator = 0
  while tracker < 12
    if hourly_data[tracker].fetch("precipProbability") > 0.5
      rain_chance_over_50_indicator = rain_chance_over_50_indicator + 1
    end
    tracker = tracker + 1
  end

  if rain_chance_over_50_indicator > 0
    p "You should take an umbrella!"
  end

  #Email and Texting with Mailgun and Twilio
  # Retrieve your credentials from secure storage
  # mg_api_key = ENV.fetch("MAILGUN_API_KEY")
  # mg_sending_domain = ENV.fetch("MAILGUN_SENDING_DOMAIN")

  # # Create an instance of the Mailgun Client and authenticate with your API key
  # mg_client = Mailgun::Client.new(mg_api_key)

  # # Craft your email as a Hash with these four keys
  # email_parameters =  { 
  #   :from => "umbrella@appdevproject.com",
  #   :to => "thegegors@gmail.com",  # Put your own email address here if you want to see it in action
  #   :subject => "Take an umbrella today!",
  #   :text => "It's going to rain today, take an umbrella with you!"
  # }

  # Send your email!
  #mg_client.send_message(mg_sending_domain, email_parameters)

  # Retrieve your credentials from secure storage
  # twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
  # twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
  # twilio_sending_number = ENV.fetch("TWILIO_SENDING_PHONE_NUMBER")

  # # Create an instance of the Twilio Client and authenticate with your API key
  # twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

  # # Craft your SMS as a Hash with three keys
  # sms_parameters = {
  #   :from => twilio_sending_number,
  #   :to => "+17039457460", # Put your own phone number here if you want to see it in action
  #   :body => "It's going to rain today — take an umbrella!"
  # }

  # Send your SMS!
  #twilio_client.api.account.messages.create(sms_parameters)
end