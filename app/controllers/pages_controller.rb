class PagesController < ApplicationController
  require 'open-uri'

  def home
  end

  def answer
    @hash = {}
    answers_json.each do |answer|
      postal = answer['context'].find { |element| element['id'].include?("postcode") }
      if postal.nil?
        @hash["error"] = "postal code not found"
      else
        postal = postal["text"]
        @hash.key?(postal) ? @hash[postal] << answer['text'] : @hash[postal] = [answer['text']]
      end
    end
    render json: @hash
  end

  def answers_json
    @city = answer_params["city"]
    @poi = PointsOfInterest.find(params[:poi_id])
    coord = Geocoder.coordinates(@city)
    lat = coord[0]
    lng = coord[1]
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{@poi.name.gsub(' ', '%20')}.json?limit=10&proximity=#{lng}%2C#{lat}&types=poi&access_token=#{ENV['MAPBOX_API_KEY']}"
    @answer_serialized = URI.open(url).read
    JSON.parse(@answer_serialized)["features"]
  end

  private

  def answer_params
    params.require(:answer).permit(:city, :query)
  end
end