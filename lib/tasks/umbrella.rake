task(:umbrella) do
  user_location = "1 VANDYKE ST, DEWEY BEACH, DE"
  geocoding_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GEOCODING_API_KEY")

  address_raw_file = open(geocoding_url).read
  address_parsed_file = JSON.parse(address_raw_file)
  results = address_parsed_file.fetch("results")[0]
  geometry = results.fetch("geometry")
  location = geometry.fetch("location")
  latitude = location.fetch("lat")
  longitude = location.fetch("lng")
  p latitude
  p longitude

  # weather_url = "https://api.darksky.net/forecast/" + ENV.fetch("DARKSKY_API_KEY") + "/41.8887,-87.6355"
  # weather_raw_file = open(weather_url).read
  # weather_parsed_file = JSON.parse(weather_raw_file)
  # ap weather_parsed_file.keys
  # currently = weather_parsed_file.fetch("currently")
  # ap currently.fetch("temperature")

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