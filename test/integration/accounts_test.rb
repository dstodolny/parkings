require 'test_helper'
require 'capybara/rails'

class AccountsTest < ActionDispatch::IntegrationTest

  setup do
    Capybara.reset!
  end

  test "user opens account registration form" do
    visit "/accounts/new"

    assert has_content? "New Account"
  end

  test "user can create a new account" do
    visit "/accounts/new"

    fill_in "account_email", with: "test@test.pl"
    fill_in "account_password", with: "123456"
    fill_in "account_password_confirmation", with: "123456"
    fill_in "account_person_attributes_first_name", with: "John"
    fill_in "account_person_attributes_last_name", with: "Doe"

    click_button "Create Account"

    assert has_content? "Account has been successfully created."
  end

  test "user can't create an account with wrong password confirmation" do
    visit "/accounts/new"

    fill_in "account_email", with: "test@test.pl"
    fill_in "account_password", with: "123456"
    fill_in "account_password_confirmation", with: "blablabla"
    fill_in "account_person_attributes_first_name", with: "John"
    fill_in "account_person_attributes_last_name", with: "Doe"

    click_button "Create Account"

    assert has_content? "error"
  end

  test "user can't create an account with duplicate email" do
    visit "/accounts/new"

    fill_in "account_email", with: "d.stodolny@gmail.com"
    fill_in "account_password", with: "123456"
    fill_in "account_password_confirmation", with: "123456"
    fill_in "account_person_attributes_first_name", with: "John"
    fill_in "account_person_attributes_last_name", with: "Doe"

    click_button "Create Account"

    assert has_content? "error"
  end

  test "user can't create an account without providing the email" do
    visit "/accounts/new"

    fill_in "account_password", with: "123456"
    fill_in "account_password_confirmation", with: "123456"
    fill_in "account_person_attributes_first_name", with: "John"
    fill_in "account_person_attributes_last_name", with: "Doe"

    click_button "Create Account"

    assert has_content? "error"
  end

  test "user receives an email after registering successfully" do
    visit "/accounts/new"

    fill_in "account_email", with: "dudus@pepik.pl"
    fill_in "account_password", with: "123456"
    fill_in "account_password_confirmation", with: "123456"
    fill_in "account_person_attributes_first_name", with: "Dudus"
    fill_in "account_person_attributes_last_name", with: "Pepik"

    click_button "Create Account"

    assert_equal "dudus@pepik.pl", ActionMailer::Base.deliveries.last.to.first
  end
end
