module OpenHazards

  def self.get_probability(city = "San Francisco, CA", magnitude = 3.0, radius = 100, days = 1)

    # Get probability data from openhazards
    url = URI.encode("http://api.openhazards.com/GetEarthquakeProbability?q=#{city}&m=#{magnitude}&r=#{radius}&w=#{days}")

    response = HTTParty.get(url)

    response.parsed_response['xmlresponse']['forecast']['prob']
  end
end