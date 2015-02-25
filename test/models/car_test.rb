require 'test_helper'

class CarTest < ActiveSupport::TestCase

  def setup
    owner = Person.new(first_name: "Dominik", last_name: "Stodolny")
    @car = Car.new(registration_number: "AAA1000", model: "Tesla Roadster", owner: owner)
  end

  test "should be valid" do
    assert @car.valid?
  end

  test "registration number should be present" do
    @car.registration_number = ""
    assert_not @car.valid?
  end

  test "model should be present" do
    @car.model = ""
    assert_not @car.valid?
  end

  test "owner should be present" do
    @car.owner = nil
    assert_not @car.valid?
  end
end
