class PlaceRent < ActiveRecord::Base
  belongs_to :parking
  belongs_to :car
  validates_presence_of :starts_at, :ends_at, :parking, :car

  before_create do
    self.price = calculate_price
    self.slug = to_slug
  end

  def calculate_price
    days, hours = days_hours(starts_at, ends_at)

    parking.day_price * days + parking.hour_price * hours
  end

  def finish
    self.ends_at = Time.now if ends_at > Time.now
  end

  def to_slug
    SecureRandom.uuid
  end

  def to_param
    slug
  end

  private

  def days_hours(start_time, end_time)
    diff = end_time.to_i - start_time.to_i

    days = diff / (24 * 3600)
    hours = ((diff % (24 * 3600)) / 3600.0).ceil

    [days, hours]
  end
end
