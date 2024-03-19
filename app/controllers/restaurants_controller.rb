class RestaurantsController < ApplicationController
  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_owner.create_restaurant(restaurant_params)
    if @restaurant.save!
      flash[:notice] = t('.sucess', brand_name: @restaurant.brand_name)
      redirect_to restaurant_path(@restaurant)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:brand_name, :corporate_name, :registration_number, :phone_number,
    :email, :address, :neighborhood, :city, :state, :zipcode, :payment_method_id,
    :description, :estimated_time, :cancelation_policy, :owner_id)
  end
end