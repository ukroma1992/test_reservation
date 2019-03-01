class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :party_size, :date, :time, presence: true

  private 

  def availability
    if !restaurant.available?(party_size, date, time)
      errors.add(:base, "Restaurant is full")
    end
  end
end
