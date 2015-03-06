class Car < ActiveRecord::Base
  belongs_to :owner, class_name: "Person"
  has_many :place_rents
  validates_presence_of :registration_number, :model, :owner
  dragonfly_accessor :image
  validates_size_of :image, maximum: 200.kilobytes
  validates_property :format, of: :image, in: %w(jpeg png gif)

  before_validation { self.image = nil if @delete_image }

  def delete_image
    @delete_image ||= false
  end

  def delete_image=(value)
    @delete_image  = !value.to_i.zero?
  end

  def permalink
    "#{id}-#{model.parameterize}"
  end

  def to_param
    permalink
  end
end
