class PointsOfInterestsController < ApplicationController
  def index
    @pois = PointsOfInterest.where("lower(name) like ?", "%#{params[:q].downcase}%")
  end
end
