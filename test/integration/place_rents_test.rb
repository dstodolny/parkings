require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest

  setup do
    visit "/sessions/new"
    fill_in "Email", with: "jan@kowalski.pl"
    fill_in "Password", with: "87654321"
    click_button "Log In"
  end

  test "user opens place rents index" do
    visit "/place_rents"
    assert has_content? "Place Rents"
  end

  test "users rents a place on a parking" do
    time = "02/03/2015 22:30".to_time
    visit "/parkings"

    within first("tr", text: "Warszawa") do
      click_link("Rent a place")
    end

    select_date_and_time(time - 1, from: "Starts at")
    select_date_and_time(time, from: "Ends at")
    select "Ford Mustang", from: "Car"

    click_button "Create Place rent"
    assert has_content? "Ford Mustang"
    assert has_content? "March 2nd, 2015 22:29"
    assert has_content? "March 2nd, 2015 22:30"
    assert has_content? "Warszawa"
  end

  test "user can see a price in place rents list" do
    visit "/place_rents"

    assert has_content? "Price"
    assert has_content? "77.0"
  end

  private

  def select_date_and_time(date, options = {})
    field = "place_rent_" + options[:from].parameterize.underscore

    select date.strftime('%Y'), from: "#{field}_1i" # year
    select date.strftime('%B'), from: "#{field}_2i" # month
    select date.strftime('%-d'), from: "#{field}_3i" # day
    select date.strftime('%H'), from: "#{field}_4i" # hour
    select date.strftime('%M'), from: "#{field}_5i" # minute
  end
end
