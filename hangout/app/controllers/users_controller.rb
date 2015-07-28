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

  def show # view not finished
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

  # We don't want other users to edit another user's info or favorites. 
  # This method below will allow us to ensure that the correct user has access to edit his or her info. 
  def ensure_correct_user 
    # compare some params vs something in the session/current_user
    unless params[:id].to_i == session[:user_id]
      redirect_to all_teams_path, alert: "Not Authorized"
    end
  end

end
