class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :lastname])
  end

  def force_restaurant_creation_for_owners
    if current_owner && current_owner.restaurant.nil?
      flash[:alert] = I18n.t('actions.force_restaurant_creation_for_owners.redirect')
      redirect_to new_restaurant_path
    end
  end
end
