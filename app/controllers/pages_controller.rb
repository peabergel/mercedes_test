class PagesController < ApplicationController
  require 'open-uri'

  def home
  end

  def answer
    @city = answer_params["city"]
    @query = answer_params["query"]
    coordinates = Geocoder.coordinates(@city)
    mapbox_key = "pk.eyJ1IjoiZWxlbmRpbGwiLCJhIjoiY2tvMnZkMmplMG1hajJvbHl0bjh1ZXBhayJ9.o-vbFb1OhCH322s-HLd1lg"
    lat = coordinates[0]
    lng = coordinates[1]
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{@query}.json?limit=5&proximity=#{lng}%2C#{lat}&types=poi&access_token=#{mapbox_key}"
    @answer_serialized = URI.open(url).read
    @answers = JSON.parse(@answer_serialized)
    render json: @answers
  end

  private

  def answer_params
    params.require(:answer).permit(:city, :query)
  end
end