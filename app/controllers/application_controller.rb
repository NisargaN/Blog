class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

before_action :configure_permitted_parameters, if: :devise_controller?

rescue_from CanCan::AccessDenied do 
	redirect_to root_path, notice: " You are not accessible to this page"
end
	


  protected

#   def configure_permitted_parameters
#     devise_parameter_sanitizer.permit(:sign_up, keys:[:username, :gender])
#   end

# end

def configure_permitted_parameters
  registration_params = [:username, :gender]

  if params[:action] == 'create'
    devise_parameter_sanitizer.for(:sign_in) do
      |u| u.permit(registration_params)
    end
  end
end
end

