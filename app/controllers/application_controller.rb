class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_teacher!
  rescue_from ActionController::UnknownFormat, with: :raise_not_found

  protected
  
  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
	end
	
  def raise_not_found
    redirect_to root_path
  end
  
end
