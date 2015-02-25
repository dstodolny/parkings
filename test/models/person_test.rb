require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  setup do
    @person = Person.new(first_name: "Dominik", last_name: "Stodolny")
  end

  test "should be valid" do
    assert @person.valid?
  end

  test "first_name should be present" do
    @person.first_name = ""
    assert_not @person.valid?
  end

  test "last_name should be present" do
    @person.last_name = ""
    assert_not @person.valid?
  end
end
