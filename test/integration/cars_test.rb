require 'test_helper'
require 'capybara/rails'

class ParkingsTest < ActionDispatch::IntegrationTest

  setup do
    visit "/sessions/new"
    fill_in "Email", with: "jan@kowalski.pl"
    fill_in "Password", with: "87654321"
    click_button "Log In"
  end

  test "user opens cars index" do
    visit "/cars"
    assert has_content? "Cars"
  end

  test "user opens car details" do
    visit "/cars"
    within first("tr", text: "Ford Mustang") do
      click_link("Show")
    end

    assert has_content? "Ford Mustang"
    assert has_content? "BBB1111"
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
    within first("tr", text: "Ford Mustang") do
      click_link("Remove")
    end

    assert has_no_content? "Ford Mustang"
  end

  test "user can add an image" do
    visit "/cars/new"

    fill_in "Model", with: "Fiat 126p"
    fill_in "Registration number", with: "A1B2C3"
    attach_file "car_image", "test/fixtures/images/car.jpg"

    click_button "Create Car"
    assert has_content? "Fiat 126p"
    assert page.find('img')['src'].include? "car.jpg"
  end

  test "user can remove the image" do
    visit "/cars/new"

    fill_in "Model", with: "Maluch"
    fill_in "Registration number", with: "A1B2C3"
    attach_file "car_image", "test/fixtures/images/car.jpg"

    click_button "Create Car"
    visit "/cars"
    within first("tr", text: "Maluch") do
      click_link("Edit")
    end
    find(:css, "#car_delete_image[value='1']").set(true)
    click_button "Update Car"
    page.assert_no_selector('img')
  end

  test "user can change the image" do
    visit "/cars/new"

    fill_in "Model", with: "Maluch"
    fill_in "Registration number", with: "A1B2C3"
    attach_file "car_image", "test/fixtures/images/car.jpg"

    click_button "Create Car"
    visit "/cars"
    within first("tr", text: "Maluch") do
      click_link("Edit")
    end
    attach_file "car_image", "test/fixtures/images/car2.jpg"
    click_button "Update Car"

    assert page.find('img')['src'].include? "car2.jpg"
  end
end
