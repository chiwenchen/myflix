require 'spec_helper'

feature 'admin can add video and user can watch' do 
  background do
    Fabricate(:category, title: 'Science Fiction')
  end
  scenario 'admin can add video' do
    sign_in_admin
    click_link("Add a video")
    page.should have_content "Add a New Video"
    fill_in('video[title]', :with => "Inception")
    fill_in('video[description]', :with => "A cool movide about hack into dream")
    fill_in('video[video_url]', :with => "some_url")
    select("Science Fiction", :from => 'video_category_id')
    attach_file(:video_image, 'public/tmp/inception_large.jpg')
    attach_file(:video_thumb_image, 'public/tmp/inception_small.jpg')
    click_button('Add Video')
    page.should have_content "You have successfully added a new video"

    click_link("Sign Out")
    sign_in
    visit(home_path)
    click_link("Inception small")
    page.should have_content "Inception"
    page.should have_content "Watch now"


  end
end