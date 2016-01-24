require 'spec_helper'

feature 'admin can see payments' do 

  background do 
    sammy = Fabricate(:user, name: 'Sammy Yeh', email: 'sammy@example.com')
    payment = Fabricate(:payment, user: sammy)
  end

  scenario 'admin can view payments' do 
    sign_in_admin
    visit admin_payments_path
    expect(page).to have_content 'Sammy Yeh'
    expect(page).to have_content 'sammy@example.com'
    expect(page).to have_content '$9.99'
    expect(page).to have_content Payment.first.reference_id
  end
  scenario 'user can not view payments' do 
    sign_in
    visit admin_payments_path
    expect(page).not_to have_content 'Sammy Yeh'
    expect(page).not_to have_content 'sammy@example.com'
    expect(page).not_to have_content '$9.99'
    expect(page).not_to have_content Payment.first.reference_id
    expect(page).to have_content "You are not permitted to visit this area"
  end
end