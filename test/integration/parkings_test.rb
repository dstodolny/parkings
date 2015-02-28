require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "user opens parkings index" do
    visit "/parkings"
    assert has_content? "Parkings"
  end

  test "user opens parking details" do
    fields = []
    visit "/parkings"

    within first("a", text: "Show").find(:xpath, "../..") do
      4.times { |i| fields[i] = all("td")[i].text }
      click_link("Show")
    end

    assert fields.all? { |field| has_content? field }
  end

  test "user adds a new parking" do
    visit "/parkings/new"

    fill_in "Places", with: "4"
    select "Outdoor", from: "Kind"
    fill_in "Hour price", with: "9"
    fill_in "Day price", with: "90"
    fill_in "City", with: "New York"
    fill_in "Street", with: "5th avenue"
    fill_in "Zip code", with: "00-000"
    click_button "Create Parking"

    assert has_content? "New York"
  end

  test "user edits a parking" do
    visit "/parkings"

    first("a", text: "Edit").click

    fill_in "City", with: "Moscow"
    click_button "Update Parking"

    assert has_content? "Moscow"
  end

  test "user removes a parking" do
    visit "/parkings"

    elements = all("tr").count
    first("a", text: "Remove").click

    all("tr").count == elements - 1
  end
end
