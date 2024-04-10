class ItemsController < ApplicationController
  before_action :authenticate_owner!, except: [:show]
  before_action :set_item, only: [:show, :edit, :update, :inactive, :active]
  before_action :set_menu, only: [:new, :create, :edit, :update, :show, :inactive, :active]
  before_action :check_owner, only: [:new, :create, :edit, :update, :inactive, :active]

  def show
  end

  def new
    @item = Item.new
  end
  def create
    @item = @menu.items.new(item_params)
    if @item.save
      flash[:notice] = t('.success', name: @item.name)
      redirect_to item_path(@item)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = t('.success', name: @item.name)
      redirect_to @item
    else
      flash.now[:alert] = t('.error')
      render :edit
    end
  end

  def inactive
    @item.inactive!
    flash[:alert] = t('.success', name: @item.name)
    redirect_to @item
  end

  def active
    @item.active!
    flash[:notice] = t('.success', name: @item.name)
    redirect_to @item
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_menu
    if params[:menu_id]
      @menu = Menu.find(params[:menu_id])
    else
      @menu = @item.menu
    end
  end

  def set_restaurant
    if params[:restaurant_id]
      @restaurant = Restaurant.find(params[:restaurant_id])
    else
      @restaurant = @menu.restaurant
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :menu_id,
                                :spice_level, :additional, :vegan, :vegetarian, :gluten_free)
  end

  def check_owner
    if current_owner != @menu.restaurant.owner
      flash[:alert] = t('.error')
      redirect_to root_path
    end
  end
end