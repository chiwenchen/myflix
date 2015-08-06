require 'spec_helper'

feature 'user interacts with video queue' do 
  scenario 'user add and reorders the queue' do
    fiction = Fabricate(:category, title: 'fiction')
    inception = Fabricate(:video, title: 'inception', category: fiction)
    future = Fabricate(:video, title: 'future', category: fiction)
    interstellar = Fabricate(:video, title:'interstellar', category: fiction)
    sign_in

    find("a[href='/videos/#{inception.id}']").click
    page.should have_content inception.title

    click_link("+ My Queue")
    page.should have_content inception.title

    visit video_path(inception)
    page.should_not have_content "+ My Queue"

    visit home_path
    find("a[href='/videos/#{future.id}']").click
    click_link("+ My Queue")
    visit home_path
    find("a[href='/videos/#{interstellar.id}']").click
    click_link("+ My Queue")

    find("input[data-video-id='#{inception.id}']").set(2)
    find("input[data-video-id='#{interstellar.id}']").set(1)
    find("input[data-video-id='#{future.id}']").set(3)

    expect(find("input[data-video-id='#{inception.id}']").value).to eq("2")
    expect(find("input[data-video-id='#{interstellar.id}']").value).to eq("1")
    expect(find("input[data-video-id='#{future.id}']").value).to eq("3")

  end
end