class CarsController < ApplicationController
  around_filter :catch_not_found

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

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to cars_path, flash: { error: "Car not found." }
  end
end
