require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "user logs in" do
    visit "/session/new"

    fill_in "email", with: "d.stodolny@gmail.com"
    fill_in "password", with: "12345678"
    click_button "Submit"

    assert has_content? "Dominik Stodolny"
  end

  test "don't display user name if he is not logged in" do
    visit "/session/new"

    assert has_no_content? "Dominik Stodolny"
  end
end
