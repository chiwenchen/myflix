require 'spec_helper'

describe VideosController do 
  context 'required authenticated user' do
    before do
      session[:user_id] = Fabricate(:user).id
    end 
    describe "GET show" do 
      it "find the video we want to display the detail" do 
        #setup data for test
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video) 
        # the :video inside "assigns" is the instance variable @video created by the show action
      end
      it "sets @reviews for the video" do 
        video = Fabricate(:video)
        review1 = Fabricate(:review, video: video) #if I use video: video here, it will fail
        review2 = Fabricate(:review, video: video)
        get :show, id: video.id
        expect(assigns(:reviews)).to match_array([review1, review2])
      end
      #Here we do not need to test the render function, because it's part of rails convention
    end
    describe "GET search" do 

      it "set @result if user is authenticated" do
        session[:user_id] = Fabricate(:user).id 
        video = Fabricate(:video, title: 'Toy Story') # here we can overwrite the title
        get :search, search_term: 'Story'
        expect(assigns(:result)).to eq([video])
      end
    end
  end
  describe "GET show" do 
    it "redirect to the sign in page" do 
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to front_videos_path
    end
  end
end