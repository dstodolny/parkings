class Person < ActiveRecord::Base
  has_many :parkings, :foreign_key => "owner_id"
  has_many :cars, :foreign_key => "owner_id"
  validates :first_name, presence: true
  validates :last_name, presence: true
end
