module ApplicationHelper
  def signed_in?
    session[:is_signed_in] == true
  end

  def app_title
    year = Time.now.year

    "Roanoke Fantasy Football #{year}"
  end
end
