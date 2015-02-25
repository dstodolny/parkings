class Parking < ActiveRecord::Base
  belongs_to :address
  belongs_to :owner, :class_name => "Person"
  has_many :place_rents
  validates_presence_of :places, :hour_price, :day_price
  validates_numericality_of :hour_price, :day_price
  validates :kind, inclusion: { in: %w(outdoor indoor private street) }
end
