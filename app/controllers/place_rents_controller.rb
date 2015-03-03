class PlaceRentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :car_is_someones_else

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
    @place_rent.car = current_person.cars.find(params[:place_rent][:car_id])
    if @place_rent.save
      redirect_to @place_rent
    else
      render "new"
    end
  end

  def place_rent_params
    params.require(:place_rent).permit(:starts_at, :ends_at)
  end

  def parking
    @parking ||= Parking.find(params[:parking_id])
  end

  def car_is_someones_else
    redirect_to place_rents_path, flash: { error: "Current person doesn't own that car." }
  end
end
