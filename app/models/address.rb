class Address < ActiveRecord::Base
  has_one :parking
  validates_presence_of :city, :street, :zip_code
  validates :zip_code, format: { with: /\A[\d]{2}-[\d]{3}\z/ }

  scope :in_city, ->(city) { where city: city }
end
