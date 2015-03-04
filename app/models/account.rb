class Account < ActiveRecord::Base
  has_secure_password
  belongs_to :person

  accepts_nested_attributes_for :person

  validates_presence_of :email
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    account = find_by_email(email)
    if account && account.authenticate(password)
      account
    end
  end
end
