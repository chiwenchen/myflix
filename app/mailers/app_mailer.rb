class AppMailer < ActionMailer::Base
  def send_welcome_message(new_user)
    @new_user = new_user
    mail from: 'myflix@google.com', to: @new_user.email, subject: 'welcome to myflix'
  end

  def send_reset_password(user)
    @user = user
    mail from: 'myflix@google.com', to: @user.email, subject: 'reset your password'
  end
end