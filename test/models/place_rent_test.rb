require 'test_helper'

class PlaceRentTest < ActiveSupport::TestCase

  setup do
    @place_rent = place_rents(:one)
  end

  test "is valid with proper data" do
    assert @place_rent.valid?
  end

  test "is invalid without starts_at" do
    @place_rent.starts_at = ""
    @place_rent.valid?
    assert @place_rent.errors.messages.keys.include?(:starts_at)
  end

  test "is invalid without ends_at" do
    @place_rent.ends_at = ""
    @place_rent.valid?
    assert @place_rent.errors.messages.keys.include?(:ends_at)
  end

  test "is invalid without parking" do
    @place_rent.parking = nil
    @place_rent.valid?
    assert @place_rent.errors.messages.keys.include?(:parking)
  end

  test "is invalid without car" do
    @place_rent.car = nil
    @place_rent.valid?
    assert @place_rent.errors.messages.keys.include?(:car)
  end

  test "is valid when calculating the correct price" do
    assert_equal 77, @place_rent.calculate_price
  end

  test "correct price is being saved in place rent object" do
    parking = parkings(:two)
    car = cars(:one)

    @place_rent = parking.place_rents.build(starts_at: "01/03/2015 22:30".to_time, ends_at: "02/03/2015 22:30".to_time, car: car)
    @place_rent.save

    assert_equal 100, @place_rent.price
  end
end
