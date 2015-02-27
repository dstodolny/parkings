class PlaceRentsController < ApplicationController
  def index
    @place_rents = current_user.place_rents.all
  end

  def show
    @place_rent = current_user.place_rents.find(params[:id])
  end
end
