class Person < ActiveRecord::Base
  has_many :parkings, foreign_key: "owner_id"
  has_many :cars, foreign_key: "owner_id"
  has_many :place_rents, through: :cars
  has_one :account
  has_one :facebook_account
  validates :first_name, presence: true

  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
