class PlaceRentsController < ApplicationController
  def index
    @place_rents = current_person.place_rents.all
  end

  def show
    @place_rent = current_person.place_rents.find(params[:id])
  end

  def new
    @cars = current_person.cars
    @place_rent = parking.place_rents.build
  end

  def create
    @place_rent = parking.place_rents.build(place_rent_params)

    if @place_rent.save
      redirect_to @place_rent
    else
      render "new"
    end
  end

  def place_rent_params
    params.require(:place_rent).permit(:starts_at, :ends_at, :car_id)
  end

  def parking
    @parking ||= Parking.find(params[:parking_id])
  end
end
