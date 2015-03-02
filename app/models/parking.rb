class Parking < ActiveRecord::Base
  KINDS = %w(outdoor indoor private street)

  belongs_to :address
  belongs_to :owner, class_name: "Person"
  has_many :place_rents

  accepts_nested_attributes_for :address

  validates_presence_of :places, :hour_price, :day_price
  validates_numericality_of :hour_price, :day_price
  validates :kind, inclusion: { in: KINDS }

  before_destroy do
    place_rents.each { |place_rent| place_rent.ends_at = Time.now }
  end
end
