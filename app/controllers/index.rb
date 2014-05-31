get '/' do
  # Look in app/views/index.erb
  erb :index
end

# TODO: Refactor this by making wrappers for Postmark and openhazards
post '/api/earthquake' do

  # This data is sent by Postmark service whenever we are notified by USGS
  email = Postmark::Mitt.new(request.body.read)
  body = email.text_body
  magnitude = body.match(/(\d\.\d+)/)[0]
  time = body.match(/UTC\s*(\d.*) near/)[1]
  location = body.match(/Location.*\s*(\d.*W)/)[1]

  # Get probability data from
  city = "San Francisco, CA"
  prob_magnitude = 3.0
  radius = 100
  days = 1
  url = URI.encode("http://api.openhazards.com/GetEarthquakeProbability?q=#{city}&m=#{prob_magnitude}&r=#{radius}&w=#{days}")

  response = HTTParty.get(url)

  probability = response.parsed_response['xmlresponse']['forecast']['prob']

  puts "An earthquake greater than #{prob_magnitude} just happened in the #{city} Bay Area"
  puts "magnitude: #{magnitude}"
  puts "time: #{time}"
  puts "location: #{location}"

  200
end
