require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "user opens cars index" do
    visit "/cars"
    assert has_content? "Cars"
  end

  test "user opens car details" do
    visit "/cars"

    first("a", text: "Show").click

    assert has_content? "Car details"
    assert has_content? "Ford Mustang"
    assert has_content? "BBB1111"
  end

  test "user adds a new car" do
    visit "/cars/new"

    fill_in "Model", with: "Trabant"
    fill_in "Registration number", with: "AAA000"
    click_button "Create Car"

    assert has_content? "Trabant"
  end

  test "user edits a car" do
    visit "/cars"

    first("a", text: "Edit").click

    fill_in "Model", with: "Trabant"
    click_button "Update Car"

    assert has_content? "Trabant"
  end

  test "user removes a car" do
    visit "/cars"

    first("a", text: "Remove").click

    assert has_no_content? "Ford Mustang"
  end
end
