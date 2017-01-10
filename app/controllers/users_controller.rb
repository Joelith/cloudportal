class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
		authorize User
		@users = User.all
  end

  def show
  	authorize @user
  end

	def edit
		authorize @user
	end

	def new
		authorize User
		@user = User.new
  end

	def destroy
		authorize @user
		@user.destroy
  	flash[:notice] = "User has been deleted."

  	redirect_to users_path
	end

  def create
  	authorize User
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Successfully created User." 
      redirect_to users_path
    else
      render :action => 'new'
    end
  end

	def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated User."
      redirect_to users_path
    else
      render :action => 'edit'
    end
  end

	private 

  def set_user
	  @user = User.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  flash[:alert] = "The user you were looking for could not be found."
	  redirect_to user_path
	end

	def user_params
  	params.require(:user).permit(:email, :password)
	end
end
