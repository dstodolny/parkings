require 'test_helper'

class ParkingTest < ActiveSupport::TestCase

  setup do
    @parking = Parking.new(places: 5, kind: "outdoor", hour_price: 10, day_price: 100)
  end

  test "should be valid" do
    assert @parking.valid?
  end

  test "places should be present" do
    @parking.places = nil
    assert_not @parking.valid?
  end

  test "hour price should be present" do
    @parking.hour_price = nil
    assert_not @parking.valid?
  end

  test "hour price should be numerical" do
    @parking.hour_price = "abcd"
    assert_not @parking.valid?
  end

  test "day price should be present" do
    @parking.day_price = nil
    assert_not @parking.valid?
  end

  test "day price should be numerical" do
    @parking.day_price = "abcd"
    assert_not @parking.valid?
  end

  test "kind validation should accept valid kinds" do
    valid_kinds = %w(outdoor indoor private street)
    valid_kinds.each do |valid_kind|
      @parking.kind = valid_kind
      assert @parking.valid?
    end
  end

  test "kind validation should reject invalid kinds" do
    invalid_kinds = %w(single loremipsum 123456)
    invalid_kinds.each do |invalid_kind|
      @parking.kind = invalid_kind
      assert_not @parking.valid?
    end
  end
end
