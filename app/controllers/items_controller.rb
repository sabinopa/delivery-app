class ItemsController < ApplicationController
  before_action :authenticate_owner!, only: [:new, :create, :edit, :update]
  before_action :set_menu, only: [:new, :create, :edit, :update]
  before_action :check_owner, only: [:new, :create, :edit, :update]

  def show
    @item = Item.find(params[:id])
    @menu = @item.menu
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
  end


  private

  def set_menu
    @menu = Menu.find(params[:menu_id])
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