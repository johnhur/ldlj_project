class SessionsController < ApplicationController

  def login
  end

  def attempt_login
  	if params[:email].present? && params[:password].present?
  	  found_user = User.where(email: params[:email]).first
  	  if found_user && found_user.authenticate(params[:password])
        session[:user_id] = nil
  	    session[:user_id] = found_user.id
  	    redirect_to users_path
  	  else
  	    flash[:alert] = "email / password combination is invalid!"
  	    redirect_to login_path(@user)
  	  end
  	else
  	  flash[:alert] = "please enter username and password"
  	  redirect_to login_path
  	end
  end
  
  def logout
    
    # current_user.lat = nil
    # current_user.lng = nil
  	session[:user_id] = nil
  	flash[:notice] = "Logged out"
  	redirect_to login_path
  end	

end
