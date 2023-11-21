class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit]
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
    @books = Book.all
  end   
  
  def index
    @user = current_user
    @users = User.all
    @books = Book.all
  end   
  
  def update
    @user = User.find(params[:id])
    user = current_user.id
    if @user.update(user_params)
       flash[:notice] = "update successfully"
       redirect_to users_path(@user.id)  
    else
      render :edit
    end   
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_path
    end
  end
end

