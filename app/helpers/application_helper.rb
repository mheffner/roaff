module ApplicationHelper
  def signed_in?
    session[:is_signed_in] == true
  end
end
