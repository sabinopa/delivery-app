class RestaurantsController < ApplicationController
  before_action :authenticate_owner!
  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_owner.create_restaurant(restaurant_params)
    if @restaurant.save!
      flash[:notice] = t('.success', brand_name: @restaurant.brand_name)
      redirect_to root_path(@restaurant)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:brand_name, :corporate_name, :registration_number, :phone_number,
    :email, :address, :neighborhood, :city, :state, :zipcode, :description, :estimated_time,
    :cancelation_policy, :owner_id, payment_method_ids: [])
  end
end