require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  setup do
    @person = people(:one)
  end

  test "is valid with proper data" do
    assert @person.valid?
  end

  test "is invalid without first_name" do
    @person.first_name = ""
    @person.valid?
    assert @person.errors.messages.keys.include?(:first_name)
  end
end
