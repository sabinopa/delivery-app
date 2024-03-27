class MenusController < ApplicationController
  before_action :authenticate_owner!, except: [:show]
  before_action :set_menu, only: [:show, :edit, :update]
  before_action :set_restaurant, only: [:new, :create, :index, :edit, :update]

  def index
    @menus = Menu.all
  end

  def show
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

  def edit
  end

  def update
    if @menu.update(menu_params)
      flash[:notice] = t('.success', name: @menu.name)
      redirect_to @menu
    else
      flash.now[:alert] = t('.error')
      render :edit
    end
  end


  private

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def set_restaurant
    if params[:restaurant_id]
      @restaurant = Restaurant.find(params[:restaurant_id])
    elsif @menu
      @restaurant = @menu.restaurant
    end
  end

  def menu_params
    params.require(:menu).permit(:name, :description)
  end
end