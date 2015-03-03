require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "user opens parkings index" do
    visit "/parkings"
    assert has_content? "Parkings"
  end

  test "user opens parking details" do
    content = []
    visit "/parkings"
    within page.all("tr")[1] do
      content[0] = all("td")[0].text
      content[1] = all("td")[1].text
      click_link("Show")
    end

    assert has_content? content[0]
    assert has_content? content[1]
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

    within page.all("tr")[1] do
      @city = all("td")[0].text
      click_link("Remove")
    end

    assert has_no_content? @city
  end

  test "search form is displayed" do
    visit "/parkings"

    assert has_content? "Search Parking"
  end

  test "data stays after submiting the form" do
    visit "/parkings"

    fill_in "City name", with: "London"
    fill_in "day_price_min", with: "90"
    fill_in "day_price_max", with: "110"
    fill_in "hour_price_min", with: "9"
    fill_in "hour_price_max", with: "11"
    find(:css, "#private[value='private']").set(true)

    click_button "Submit"

    assert_equal "London", find_field("City name").value
    assert_equal "90", find_field("day_price_min").value
    assert_equal "110", find_field("day_price_max").value
    assert_equal "9", find_field("hour_price_min").value
    assert_equal "11", find_field("hour_price_max").value
    assert_equal "checked", find(:css, "#private[value='private']").checked?
  end
end
