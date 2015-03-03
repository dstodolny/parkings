require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    visit "/sessions/new"
    fill_in "Email", with: "jan@kowalski.pl"
    fill_in "Password", with: "87654321"
    click_button "Log In"
  end

  teardown do
    Capybara.reset!
  end

  test "user opens cars index" do
    visit "/cars"
    assert has_content? "Cars"
  end

  test "user opens car details" do
    content = []
    visit "/cars"
    within page.all("tr")[1] do
      content[0] = all("td")[0].text
      content[1] = all("td")[1].text
      click_link("Show")
    end

    assert has_content? content[0]
    assert has_content? content[1]
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
    within page.all("tr")[1] do
      @model = all("td")[0].text
      click_link("Remove")
    end

    assert has_no_content? @model
  end
end
