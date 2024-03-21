class HomeController < ApplicationController
  def index
    @restaurants = Restaurant.all
    if owner_signed_in?
      @restaurant = current_owner.restaurant
    end
  end
end