class Restaurant < ApplicationRecord
  has_many :reservations
  has_many :users, through: :reservations

  def available?(party_size, date, time)
		total_reservation_count = reservations.where(date: date, time: time).sum(:party_size)
		party_size + total_reservation_count <= capacity
	end
end
