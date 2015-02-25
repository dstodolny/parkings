class PlaceRent < ActiveRecord::Base
  belongs_to :parking
  belongs_to :car
  validates_presence_of :starts_at, :ends_at, :parking, :car
end
