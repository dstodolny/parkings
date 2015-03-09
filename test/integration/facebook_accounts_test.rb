require 'test_helper'
require 'capybara/rails'

class FacebookAccountsTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
  end

  teardown do
    OmniAuth.config.mock_auth[:facebook] = nil
  end

  test "user can log in through facebook account" do
    OmniAuth.config.add_mock(:facebook, { uid: "999" })
    visit "/auth/facebook/callback"

    assert has_content? "You have been logged in."
    assert has_content? "Joe Doe"
  end

  test "user can create a new account with facebook login" do
    OmniAuth.config.add_mock(:facebook, {
      uid: "9999",
      info: {
        first_name: "Lucky",
        last_name: "Lucke"
      } })
    visit "/auth/facebook/callback"

    assert has_content? "You have been logged in."
    assert has_content? "Lucky Lucke"
  end
end
