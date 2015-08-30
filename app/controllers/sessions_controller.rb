class SessionsController < ApplicationController
  USERNAME = "roanoke"
  PASSWORD = "fantasy"

  def new

  end

  def signin
    if params[:username] == USERNAME &&
        params[:password] == PASSWORD
      session[:is_signed_in] = true
      redirect_to root_path
    else
      redirect_to sessions_new_path
    end
  end

  def signout
    reset_session
    redirect_to root_path
  end
end
