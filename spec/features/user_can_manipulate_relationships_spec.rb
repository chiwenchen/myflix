require 'spec_helper'

feature 'user can manipulate relationships' do 
  scenario 'user can follow and unfollow another user' do 
    sammy = Fabricate(:user, name: 'sammy')
    bob = Fabricate(:user, name: 'bob')
    fiction = Fabricate(:category, title: 'fiction')
    inception = Fabricate(:video, title: 'inception', category: fiction)
    review = Fabricate(:review, user: bob, video: inception, body: 'this is a greate movie', rating: 5)
    sign_in(sammy)

    find("a[href='/videos/#{inception.id}']").click
    page.should have_content "inception"
    click_link("bob")
    page.should have_content 'bob'

    click_link("Follow")
    page.should have_content 'People I Follow'
    page.should have_content 'bob'

    find("a[data-method='delete']").click
    page.should have_content 'People I Follow'
    page.should_not have_content 'bob'


  end
end