require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest

  test "user logs in" do
    visit "/sessions/new"

    fill_in "email", with: "d.stodolny@gmail.com"
    fill_in "password", with: "12345678"
    click_button "Log In"

    assert has_content? "You have been logged in."
  end

  test "don't display user name if he is not logged in" do
    visit "/sessions/new"

    assert has_no_content? "Dominik Stodolny"
  end

  test "user logs out" do
    visit "/sessions/new"

    fill_in "email", with: "jan@kowalski@gmail.com"
    fill_in "password", with: "87654321"
    click_button "Log In"

    click_link "Log out"

    assert has_content? "Logged out."
  end

  test "user is redirected to cars if he logs in" do
    click_link "Log out"
    visit "/cars"

    fill_in "Email", with: "d.stodolny@gmail.com"
    fill_in "Password", with: "12345678"
    click_button "Log In"

    assert has_content? "Fiat Punto"
  end
end
