require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "user logs in" do
    visit "/sessions/new"

    fill_in "email", with: "d.stodolny@gmail.com"
    fill_in "password", with: "12345678"
    click_button "Log In"

    assert has_content? "Hello"
  end

  test "don't display user name if he is not logged in" do
    visit "/sessions/new"

    assert has_no_content? "Dominik Stodolny"
  end
end
