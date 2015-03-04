class Car < ActiveRecord::Base
  belongs_to :owner, :class_name => "Person"
  has_many :place_rents
  validates_presence_of :registration_number, :model, :owner

  def permalink
    "#{id}-#{model.parameterize}"
  end

  def to_param
    permalink
  end
end
