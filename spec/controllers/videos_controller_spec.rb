require 'spec_helper'

describe VideosController do

  context 'required authenticated user' do
    before do 
      set_current_user
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
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        get :show, id: video.id
        expect(assigns(:reviews)).to match_array([review1, review2])
      end
    end

    describe "GET search" do 
      it "set @result if user is authenticated" do
        video = Fabricate(:video, title: 'Toy Story')
        get :search, search_term: 'Story'
        expect(assigns(:result)).to eq([video])
      end
    end
  end

  describe "GET show" do 
    #video = Fabricate(:video)    can't put Fabricate outside of test sample, because it will really generate the new record in database
    it_behaves_like 'require_sign_in' do 
      let(:action){get :show, id: Fabricate(:video).id}
    end
  end
end