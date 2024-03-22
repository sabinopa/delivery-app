class HomeController < ApplicationController
  before_action :force_restaurant_creation_for_owners, only: [:index]

  def index
    @restaurants = Restaurant.all
    if owner_signed_in?
      @restaurant = current_owner.restaurant
    end
  end
end