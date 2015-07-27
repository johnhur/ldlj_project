class UsersController < ApplicationController

  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.create(user_params)
  		if @user.save
  	# redirect_to users_path,
  		else 
  			render :new
  		end	
  end		

  def edit
  end	

  def show
  end

end
