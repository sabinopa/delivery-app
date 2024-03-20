class RestaurantsController < ApplicationController
  before_action :authenticate_owner!, only: [:new, :create]

  def show
    @restaurant = Restaurant.find(params[:id])

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
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_owner.create_restaurant(restaurant_params)
    if @restaurant.save!
      flash[:notice] = t('.success', brand_name: @restaurant.brand_name)
      redirect_to restaurant_path(@restaurant)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:brand_name, :corporate_name, :registration_number, :phone_number,
                                      :email, :address, :neighborhood, :city, :state, :zipcode, :description,
                                      :estimated_time, :cancelation_policy, :vegan_options, :vegetarian_options,
                                      :gluten_free_options, :owner_id, payment_method_ids: [])
  end
end