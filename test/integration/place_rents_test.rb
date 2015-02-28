require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "user opens place rents index" do
    visit "/place_rents"
    assert has_content? "Place Rents"
  end

  test "users rents a place on a parking" do
    time = DateTime.now
    city = nil
    visit "/parkings"

    within first("a", text: "Rent a place").find(:xpath, "../..") do
      city = all("td")[0].text
      click_link("Rent a place")
    end

    select_date_and_time(time - 1, from: "Starts at")
    select_date_and_time(time, from: "Ends at")
    select "Ford Mustang", from: "Car"

    click_button "Create Place rent"
    assert has_content? "Ford Mustang"
    assert has_content?((time - 1).to_formatted_s(:long_ordinal))
    assert has_content? time.to_formatted_s(:long_ordinal)
    assert has_content? city
  end

  private

  def select_date_and_time(date, options = {})
    field = "place_rent_" + options[:from].parameterize.underscore

    select date.strftime('%Y'), from: "#{field}_1i" # year
    select date.strftime('%B'), from: "#{field}_2i" # month
    select date.strftime('%d'), from: "#{field}_3i" # day
    select date.strftime('%H'), from: "#{field}_4i" # hour
    select date.strftime('%M'), from: "#{field}_5i" # minute
  end
end
