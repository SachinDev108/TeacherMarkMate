class ApplicationController < ActionController::Base

  layout :resolve_layout
  protect_from_forgery with: :exception  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_teacher!
  rescue_from ActionController::UnknownFormat, with: :raise_not_found
  alias_method :current_user, :current_teacher

  rescue_from CanCan::AccessDenied do |exception|
    if current_teacher.is_plan_active?
      respond_to do |format|
        format.html { redirect_to main_app.root_path, alert: exception.message }
        format.js   { render flash[:notice] = exception.message, js: "window.location='#{ main_app.root_path }'" }
      end
    else
      respond_to do |format|
        format.html { redirect_to main_app.root_path, alert: "Your current subscription plan is over please renew it" }
        format.js   { render flash[:notice] = "Your current subscription plan is over please renew it", js: "window.location='#{ main_app.root_path }'" }
      end
    end
  end

  protected
  
  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :role]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
	end
	
  def raise_not_found
    redirect_to root_path
  end
  
  def after_sign_in_path_for(resource)
    resource.is_a?(Admin) ? rails_admin.index_path(Teacher) : root_path
  end

  def resolve_layout
    case action_name
    when "trial"
      "home"
    else
      "application"
    end
  end
end
