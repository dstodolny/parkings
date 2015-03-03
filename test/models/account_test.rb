require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "authenticate returns an account if credentials are correct" do
    assert Account.authenticate("d.stodolny@gmail.com", "12345678").instance_of? Account
  end

  test "authenticate returns nil if credentials are incorrect" do
    assert Account.authenticate("d.stodolny@gmail.com", "blablabla").nil?
  end
end
