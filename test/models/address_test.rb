require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  
  setup do
    @address = Address.new(city: "London", street: "Kensington 1", zip_code: "10-100")
  end

  test "should be valid" do
    assert @address.valid?
  end

  test "city should be present" do
    @address.city = ""
    assert_not @address.valid?
  end

  test "street should be present" do
    @address.street = ""
    assert_not @address.valid?
  end

  test "zip code should be present" do
    @address.zip_code = ""
    assert_not @address.valid?
  end

  test "zip code validation should accept valid zip codes" do
    valid_zip_codes = %w(00-000 12-345 99-999)
    valid_zip_codes.each do |valid_zip_code|
      @address.zip_code = valid_zip_code
      assert @address.valid?
    end
  end

  test "zip code validation should reject invalid zip codes" do
    invalid_zip_codes = %w(123-45 98765 abcdef a8s7d9f7)
    invalid_zip_codes.each do |invalid_zip_code|
      @address.zip_code = invalid_zip_code
      assert_not @address.valid?
    end
  end
end
