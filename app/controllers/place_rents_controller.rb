class PlaceRentsController < ApplicationController
  def index
    @place_rents = PlaceRent.all
  end

  def show
    @place_rent = PlaceRent.find(params[:id])
  end
end
