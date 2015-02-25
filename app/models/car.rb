class Car < ActiveRecord::Base
  belongs_to :owner, :class_name => "Person"
  has_many :place_rents
  validates :registration_number, presence: true
  validates :model, presence: true
  validates :owner, presence: true
end
