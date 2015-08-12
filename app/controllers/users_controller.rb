class UsersController < ApplicationController

  before_action :require_user, only: [:people]

  def new
    if logged_in?
      redirect_to home_path
    end
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(strong_params)
    if @user.save
      flash[:success] = 'You are successful Registed and Signed in'
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render 'new'
    end
  end

  private

  def strong_params
    (params.require(:user).permit(:name, :password, :email))
  end


end