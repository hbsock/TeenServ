class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
      [:username,
       :email,
       :password,
       :password_confirmation,
       :name,
	   :account_type])
  end

  def redirect_if_not_admin
    if !(current_user.admin?)
      redirect_to root_path
    end
  end

  def redirect_if_not_client
    if !(current_user.account_type == "client")
      redirect_to root_path
    end
  end



end
