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
  			redirect_to users_path, flash: {success: "#{@user.first_name} created"}
  		else 
  			render :new
  		end	
  end		

  def edit
  end	

  def show
  end

  private
  def user_params
  	params.require(:user).permit(
  		:first_name,
  		:email,
  		:img_url,
  		:address,
  		:password
  		)
  end	
end
