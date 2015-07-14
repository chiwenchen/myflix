require 'spec_helper'

describe ReviewsController do 
  describe "POST create" do 
    context 'user is authenticated' do 
      before do 
        set_current_user
      end
      context 'review is valid' do   
        let(:review) {Fabricate.attributes_for(:review)}
        let(:video) {Video.find(review[:video_id])}
        before do 
          post :create, review: review, video_id: video.id
        end

        it "saves review" do 
          expect(Review.count).to eq(1)
        end

        it "shows flash notice" do 
          expect(flash[:success]).not_to be_blank
        end

        it "redirect_to show video page" do 
          expect(response).to redirect_to video_path(review[:video_id])
        end
      end

      context 'review is unvalid' do 
        let(:video) {Fabricate(:video)}
        before do 
          post :create, review: {rating: 3}, video_id: video.id
        end

        it 'do not save review' do 
          expect(Review.count).to eq(0)
        end

        it 'render the video template' do 
          expect(response).to redirect_to video_path(video)
        end
      end
    end
    context 'no authenticated user' do 
      let(:review) {Fabricate.attributes_for(:review)}
      before do 
        session[:user_id] = nil
        post :create, review: review
      end

      it 'redirect_to front_videos_path' do 
        expect(response).to redirect_to front_videos_path
      end
      
      it 'shows flash notice' do 
        expect(flash[:danger]).not_to be_blank
      end
    end
  end
end