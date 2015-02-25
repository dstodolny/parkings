require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  
  setup do
    @address = addresses(:one)
  end

  test "is valid with proper data" do
    assert @address.valid?
  end

  test "is invalid without city" do
    @address.city = ""
    @address.valid?
    assert @address.errors.messages.keys.include?(:city)
  end

  test "is invalid without street" do
    @address.street = ""
    @address.valid?
    assert @address.errors.messages.keys.include?(:street)
  end

  test "is invalid without zip code" do
    @address.zip_code = ""
    @address.valid?
    assert @address.errors.messages.keys.include?(:zip_code)
  end

  test "is valid with proper zip code" do
    @address.zip_code = "00-100"
    @address.valid?
    assert_not @address.errors.messages.keys.include?(:zip_code)
  end

  test "is invalid with improper zip code" do
    @address.zip_code = "888-99"
    @address.valid?
    assert @address.errors.messages.keys.include?(:zip_code)
  end
end
