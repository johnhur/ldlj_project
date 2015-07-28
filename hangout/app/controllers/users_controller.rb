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

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end	

  def update
    @user = User.find params[:id]
    @user.update user_params
    if @user.save
      redirect_to users_path, flash: {success: "#{@user.first_name} updated"}
    else
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "User Deleted"
    redirect_to login_path
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
