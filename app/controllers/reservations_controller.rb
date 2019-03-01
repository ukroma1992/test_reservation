class ReservationsController < ApplicationController
  before_action :ensure_logged_in, only: [:create, :destroy]
	before_action :load_restaurant

  def show
    @reservation = Reservation.find(params[:id])
  end

	def new
    @reservation = Reservation.new
  end

  def create
  	@reservation = @restaurant.reservations.build(reservation_params)
  	@reservation.user = current_user
		if @reservation.save
  		redirect_to restaurant_path(params[:restaurant_id]), notice: "Your reserve table!"
  	else
  		flash[:alert] = @reservation.errors.full_messages.to_sentence
  		redirect_to new_restaurant_reservation_path(@restaurant, @reservation)
  	end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update_attributes(reservation_params)
      redirect_to restaurant_path(@restaurant)
    else
      flash[:alert] = @reservation.errors.full_messages.to_sentence
      redirect_to edit_restaurant_reservation_path(@restaurant, @reservation)
    end
  end

	def destroy
		@reservation = Reservation.find(params[:id])
		@reservation.destroy
		redirect_to restaurant_path, notice: "Your reservation has been cancelled."
	end

  private

  def reservation_params
    params.require(:reservation).permit(:party_size, :date, :time)
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
