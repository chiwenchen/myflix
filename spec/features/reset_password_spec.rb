require 'spec_helper'

feature "ActionMailer" do 
  background do 
    @sammy = Fabricate(:user, email: 'sammy@example.com', name: 'sammy', password: 'old_password')
  end

  scenario "forget password and make reset password request" do 
    visit signin_path
    click_link "forget password"
    page.has_content?('Forget Password?')

    fill_in(:email, :with => @sammy.email)
    click_button('Send Email')
    open_email(@sammy.email)
    expect(current_email).to have_content('please click below link to reset your password')

    current_email.click_link "Reset your password"
    expect(page).to have_content 'Reset Your Password'

    fill_in('new_password', :with => 'new_password')
    click_button "Reset Password"
    page.has_content?('Sign in')

    fill_in('email', :with => @sammy.email)
    fill_in('password', :with => "new_password")
    click_button "Sign in"
    page.has_content?('You are Signed in!')
  end
end