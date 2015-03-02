require 'test_helper'

class ParkingTest < ActiveSupport::TestCase

  setup do
    @parking = parkings(:one)
  end

  test "is valid with proper data" do
    assert @parking.valid?
  end

  test "is invalid without places" do
    @parking.places = nil
    @parking.valid?
    assert @parking.errors.messages.keys.include?(:places)
  end

  test "is invalid without hour price" do
    @parking.hour_price = nil
    @parking.valid?
    assert @parking.errors.messages.keys.include?(:hour_price)
  end

  test "is invalid with non-decimal hour price" do
    @parking.hour_price = "abcd"
    @parking.valid?
    assert @parking.errors.messages.keys.include?(:hour_price)
  end

  test "is invalid without day price" do
    @parking.day_price = nil
    @parking.valid?
    assert @parking.errors.messages.keys.include?(:day_price)
  end

  test "is invalid with non-decimal day price" do
    @parking.day_price = "abcd"
    @parking.valid?
    assert @parking.errors.messages.keys.include?(:day_price)
  end

  test "is valid with proper kinds" do
    valid_kinds = %w(outdoor indoor private street)
    valid_kinds.each do |valid_kind|
      @parking.kind = valid_kind
      @parking.valid?
      assert_not @parking.errors.messages.keys.include?(:kind)
    end
  end

  test "is invalid with improper kinds" do
    @parking.kind = "single"
    @parking.valid?
    assert @parking.errors.messages.keys.include?(:kind)
  end

  test "just before destroy all rentals ends at current time" do
    time = DateTime.now
    car = cars(:one)
    @place_rent = @parking.place_rents.build(starts_at: time - 1, ends_at: time + 1, car: car)

    @parking.destroy
    assert_in_delta time.to_i, @place_rent.ends_at.to_i, 5
  end
end
