require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "user opens place rents index" do
    visit "/place_rents"
    assert has_content? "Place Rents"
  end

  test "users rents a place on a parking" do
    time = "02/03/2015 22:30".to_time
    visit "/parkings"

    first("a", text: "Rent a place").click

    select_date_and_time(time - 1, from: "Starts at")
    select_date_and_time(time, from: "Ends at")
    select "Ford Mustang", from: "Car"

    click_button "Create Place rent"
    assert has_content? "Ford Mustang"
    assert has_content?((time - 1).to_formatted_s(:long_ordinal))
    assert has_content? time.to_formatted_s(:long_ordinal)
    assert has_content? "Warszawa"
  end

  test "user can see a price in place rents list" do
    visit "/place_rents"

    assert has_content? "Price"

    within first("a", text: "Show").find(:xpath, "../..") do
      assert_equal "77.0", all("td")[2].text
    end
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
