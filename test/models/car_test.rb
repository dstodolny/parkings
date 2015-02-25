require 'test_helper'

class CarTest < ActiveSupport::TestCase

  setup do
    @car = cars(:one)
  end

  test "is valid with proper data" do
    assert @car.valid?
  end

  test "is invalid without registration number" do
    @car.registration_number = ""
    @car.valid?
    assert @car.errors.messages.keys.include?(:registration_number)
  end

  test "is invalid without model" do
    @car.model = ""
    @car.valid?
    assert @car.errors.messages.keys.include?(:model)
  end

  test "is invalid owner should be present" do
    @car.owner = nil
    @car.valid?
    assert @car.errors.messages.keys.include?(:owner)
  end
end
