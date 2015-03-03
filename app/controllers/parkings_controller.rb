class ParkingsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :parking_not_found

  def index
    @parkings = search(params)
  end

  def show
    @parking = Parking.find(params[:id])
  end

  def new
    @parking = Parking.new
    @parking.build_address
  end

  def edit
    @parking = Parking.find(params[:id])
  end

  def create
    @parking = Parking.new(parking_params)

    if @parking.save
      redirect_to @parking
    else
      render "new"
    end
  end

  def update
    @parking = Parking.find(params[:id])

    if @parking.update(parking_params)
      redirect_to @parking
    else
      render "edit"
    end
  end

  def destroy
    @parking = Parking.find(params[:id])
    @parking.destroy

    redirect_to parkings_path
  end

  private

  def parking_params
    params.require(:parking).permit(:places, :kind, :hour_price, :day_price,
                                    address_attributes: [:street, :zip_code, :city])
  end

  def search(params)
    parkings = Parking.all
    parkings = parkings.private_parkings if params[:private].present?
    parkings = parkings.public_parkings if params[:public].present?
    parkings = parkings.day_price_from_to(params[:day_price_min], params[:day_price_max]) if params[:day_price_min].present? && params[:day_price_max].present?
    parkings = parkings.hour_price_from_to(params[:hour_price_min], params[:hour_price_max]) if params[:hour_price_min].present? && params[:hour_price_max].present?
    parkings = parkings.in_city(params[:city_name]) if params[:city_name].present?
    parkings
  end

  def parking_not_found
    redirect_to parkings_path, flash: { error: "Parking not found." }
  end
end
