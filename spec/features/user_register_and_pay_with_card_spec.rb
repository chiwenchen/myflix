require 'spec_helper'

feature 'user register and pay with card', {js: true, vcr: true} do 

  background do 
    visit register_path
  end
  scenario 'with valid user info and credit card' do 
    fill_in_form('4242424242424242')
    page.should have_content 'You are successful Registed and Signed in'
  end
  scenario 'with valid user info and invalid card' do 
    fill_in_form('123')
    page.should have_content 'This card number looks invalid.'
  end
  scenario 'with valid user info and declined card' do 
    fill_in_form('4000000000000002')
    page.should have_content 'Your card was declined.'
  end
  scenario 'with invalid user info and valid card'
  scenario 'with invalid user info and invalid card'
  scenario 'with invalid user info and declined card'

  def fill_in_form(card_number)
    fill_in 'Email', with: 'salus@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Name', with: 'Salus'
    fill_in 'Card-number', with: card_number
    fill_in 'Security-code', with: '123'
    select '5 - May', from: 'date_month'
    select '2018', from: 'date_year'
    click_button 'Sign Up'
  end
end