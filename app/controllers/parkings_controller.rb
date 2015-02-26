class ParkingsController < ApplicationController
  def index
    @parkings = Parking.all
  end

  def show
    @parking = Parking.find(params[:id])
  end
end
