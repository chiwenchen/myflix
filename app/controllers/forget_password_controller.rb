class ForgetPasswordController < ApplicationController

  def create
    user = User.where(email: params[:email]).first
    if user
      user.generate_token
      AppMailer.send_reset_password(user).deliver
      redirect_to confirm_reset_password_path
    else
      if params[:email] == ""
        flash[:danger] = "Please enter your email address"
      else
        flash[:danger] = "Your email enter is invalid"
      end
      redirect_to forget_password_path
    end
  end

  def reset_password_page
    @token = params[:token]
  end

  def reset_password
    @user = User.find_by(token: params[:token])
    if @user.reset_password(params[:new_password])
      flash[:success] = "You changed the password, please log in with new password"
      @user.update_attribute(:token, nil)
      redirect_to signin_path
    else
      @user.errors.full_messages.each do |msg| 
        flash[:danger] = msg
      end
      redirect_to reset_password_page_path(token: params[:token])
    end
  end

end