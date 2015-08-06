require 'spec_helper'

feature 'user signs in' do 
  scenario 'with valid email and password' do 
    sammy = Fabricate(:user)
    sign_in(sammy)
    page.should have_content User.first.name
  end
end