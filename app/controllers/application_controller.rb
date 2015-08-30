class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def do_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def authorize
    if session[:is_signed_in] != true
      redirect_to sessions_new_path
    end
  end
end
