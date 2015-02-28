require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "user opens cars index" do
    visit "/cars"
    assert has_content? "Cars"
  end

  test "user opens car details" do
    fields = []
    visit "/cars"

    within first("a", text: "Show").find(:xpath, "../..") do
      2.times { |i| fields[i] = all("td")[i].text }
      click_link("Show")
    end

    assert fields.all? { |field| has_content? field }
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

    elements = all("tr").count
    first("a", text: "Remove").click

    all("tr").count == elements - 1
  end
end
