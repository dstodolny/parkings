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

  test "full name is displayed properly" do
    person1 = Person.new(first_name: "Dominik")
    person2 = Person.new(first_name: "Dominik", last_name: "Stodolny")
    assert_equal "Dominik", person1.full_name
    assert_equal "Dominik Stodolny", person2.full_name
  end
end
