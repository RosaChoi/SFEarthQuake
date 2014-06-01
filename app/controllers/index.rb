get '/' do

  @probability = OpenHazards.get_probability

  last_earthquake = Earthquake.last
  @magnitude = last_earthquake.magnitude
  @time = last_earthquake.time.strftime("%A, %d %b %Y %l:%M %p")
  @location = last_earthquake.location

  erb :index
end

post '/api/earthquake' do

  # This data is sent by Postmark service whenever we are notified by USGS
  email = Postmark::Mitt.new(request.body.read)
  body = email.text_body
  magnitude = body.match(/(\d\.\d+)/)[0]
  time = body.match(/UTC\s*(\d.*) near/)[1]
  location = body.match(/Location.*\s*(\d.*W)/)[1]

  Earthquake.create magnitude: magnitude,
                    time: time,
                    location: location

  puts "An earthquake greater than 6.0 just occured"
  puts "magnitude: #{magnitude}"
  puts "time: #{time}"
  puts "location: #{location}"

  200
end
