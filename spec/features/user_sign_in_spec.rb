require 'spec_helper'

feature 'user signs in' do 

  scenario 'with valid personal info' do 
    sammy = Fabricate(:user)
    sign_in(sammy)
    page.should have_content sammy.name
  end

  scenario 'with valid personal info' do 
    sammy = Fabricate(:user)
    sign_in(sammy, 'invalid email')
    page.should have_content "Your email or password is not correct"
  end

  scenario 'de-active user can not sign in' do 
    sammy = Fabricate(:user, active: false)
    sign_in(sammy)
    page.should have_content "your account is suspended"
  end


end