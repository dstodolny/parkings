class CarsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :car_not_found
  before_action do
    session[:return_to] ||= request.original_url
    authorize
  end

  def index
    @cars = current_person.cars.all
  end

  def show
    @car = current_person.cars.find(params[:id])
  end

  def new
    @car = current_person.cars.build
  end

  def edit
    @car = current_person.cars.find(params[:id])
  end

  def create
    @car = current_person.cars.build(car_params)

    if @car.save
      redirect_to @car
    else
      render "new"
    end
  end

  def update
    @car = current_person.cars.find(params[:id])

    if @car.update(car_params)
      redirect_to @car
    else
      render "edit"
    end
  end

  def destroy
    @car = current_person.cars.find(params[:id])
    @car.destroy

    redirect_to cars_path
  end

  private

  def car_params
    params.require(:car).permit(:model, :registration_number)
  end

  def car_not_found
    redirect_to cars_path, flash: { error: "Car not found." }
  end
end
