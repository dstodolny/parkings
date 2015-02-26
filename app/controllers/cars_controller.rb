class CarsController < ApplicationController
  def index
    @cars = Car.where(owner: current_person)
  end

  def show
    @car = Car.where(owner: current_person).find(params[:id])
  end

  def new
    @car = Car.new
  end

  def edit
    @car = Car.find(params[:id])
  end

  def create
    @car = Car.new(car_params)
    @car.owner = current_person

    if @car.save
      redirect_to @car
    else
      render "new"
    end
  end

  def update
    @car = Car.find(params[:id])

    if @car.update(car_params)
      redirect_to @car
    else
      render "edit"
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy

    redirect_to cars_path
  end

  private

  def car_params
    params.require(:car).permit(:model, :registration_number)
  end
end
