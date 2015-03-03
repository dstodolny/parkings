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
    place_rents.each(&:finish)
  end

  scope :public_parkings, -> { where.not(kind: "private")  }
  scope :private_parkings, -> { where kind: "private" }
  scope :day_price_from_to, ->(from, to) { where("day_price >= ? AND day_price <= ?", from, to) }
  scope :hour_price_from_to, ->(from, to) { where("hour_price >= ? AND hour_price <= ?", from, to) }
  scope :in_city, ->(city) { joins(:address).merge(Address.in_city(city)) }
end
