require 'spec_helper'

feature 'user register and pay with card', :js, :vcr do 

  background {visit register_path}

  scenario 'with valid user info and credit card' do 
    fill_in_form('password','4242424242424242')
    expect(page).to have_content 'You are successful Registed and Signed in'
  end

  scenario 'with valid user info and invalid card' do 
    fill_in_form('password','123')
    expect(page).to have_content 'The card number is not a valid credit card number.'
  end

  scenario 'with valid user info and declined card' do 
    fill_in_form('password','4000000000000002')
    expect(page).to have_content 'Your card was declined.'
  end

  scenario 'with invalid user info and valid card' do 
    fill_in_form(nil,'4242424242424242')
    expect(page).to have_content "can't be blank"
  end

  scenario 'with invalid user info and invalid card' do 
    fill_in_form(nil,'123')
    expect(page).to have_content 'The card number is not a valid credit card number.'
  end

  scenario 'with invalid user info and declined card' do 
    fill_in_form(nil,'4000000000000002')
    expect(page).to have_content "can't be blank"
  end

  def fill_in_form(password, card_number)
    fill_in 'Email', with: 'salus@example.com'
    fill_in 'Password', with: password
    fill_in 'Name', with: 'Salus'
    fill_in 'Card-number', with: card_number
    fill_in 'Security-code', with: '123'
    select '5 - May', from: 'date_month'
    select '2018', from: 'date_year'
    click_button 'Sign Up'
  end
end