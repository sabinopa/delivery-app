class MenusController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_restaurant, only: [:new, :create, :index]

  def index
    @menus = Menu.all
  end

  def show
    @menu = Menu.find(params[:id])
    @restaurant = @menu.restaurant
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = @restaurant.menus.new(menu_params)
    if @menu.save
      flash[:notice] = t('.success')
      redirect_to restaurant_menus_path(@restaurant)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end


  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def menu_params
    params.require(:menu).permit(:name, :description)
  end
end