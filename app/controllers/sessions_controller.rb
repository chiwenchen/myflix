class SessionsController < ApplicationController

  before_action :require_user, only: [:destroy]

  def new
    redirect_to home_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You are Signed in!'
      redirect_to home_path
    else
      flash[:danger] = 'Your email or password is not correct' 
      render 'new'
    end 
  end

  def destroy
    flash[:warning] = "#{current_user.name}, See you next time"
    session[:user_id] = nil
    redirect_to front_path
  end
end