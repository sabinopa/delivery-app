class RestaurantsController < ApplicationController
  before_action :authenticate_owner!, only: [:new, :create, :edit, :update]
  before_action :force_restaurant_creation_for_owners, only: [:show]
  before_action :set_restaurant, only: [:show, :edit, :update]
  before_action :check_owner, only: [:edit, :update]

  def show
    @owner = current_owner

    options = []
    lacks_options = []

    options << I18n.t('restaurant.options.vegan') if @restaurant.vegan_options
    options << I18n.t('restaurant.options.vegetarian') if @restaurant.vegetarian_options
    options << I18n.t('restaurant.options.gluten_free') if @restaurant.gluten_free_options

    lacks_options << I18n.t('restaurant.options.vegan') unless @restaurant.vegan_options
    lacks_options << I18n.t('restaurant.options.vegetarian') unless @restaurant.vegetarian_options
    lacks_options << I18n.t('restaurant.options.gluten_free') unless @restaurant.gluten_free_options

    @options =  options.any? ? I18n.t('restaurant.phrases.has_options', options: options.join(" | ")) : nil
    @lacks_options = lacks_options.any? ? I18n.t('restaurant.phrases.lacks_options', options: lacks_options.join(" | ")) : nil

  end

  def new
    if current_owner.restaurant.present?
      flash[:alert] = t('.error')
      redirect_to root_path
    end
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_owner.build_restaurant(restaurant_params)
    if @restaurant.save
      flash[:notice] = t('.success', brand_name: @restaurant.brand_name)
      redirect_to restaurant_path(@restaurant)
    else
      flash[:alert] = t('.error')
      render :new
    end
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = t('.success', brand_name: @restaurant.brand_name)
      redirect_to @restaurant
    else
      flash.now[:alert] = t('.error')
      render :edit
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:owner_id,:brand_name, :corporate_name, :registration_number, :phone_number,
                                      :email, :address, :neighborhood, :city, :state, :zipcode, :description,
                                      :estimated_time, :cancelation_policy, :vegan_options, :vegetarian_options,
                                      :gluten_free_options, payment_method_ids: [])
  end

  def check_owner
    if current_owner != @restaurant.owner
      flash[:alert] = t('.error')
      redirect_to root_path
    end
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end