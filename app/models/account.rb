class Account < ActiveRecord::Base
  has_secure_password
  belongs_to :person
  attr_accessor :password, :password_confirmation

  accepts_nested_attributes_for :person

  validates_uniqueness_of :email

  def self.authenticate(email, password)
    account = find_by_email(email)
    if account && account.authenticate(password)
      account
    end
  end
end
