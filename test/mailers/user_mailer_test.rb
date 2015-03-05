require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "it sends an email" do
    @account = accounts(:one)
    UserMailer.welcome_email(@account).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
  end
end
