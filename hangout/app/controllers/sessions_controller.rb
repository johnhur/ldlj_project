class SessionsController < ApplicationController

  def login
  end

  def home
  end

  def attempt_login
  end
  
  def logout
  	sessions[:user_id]
  end	

end
