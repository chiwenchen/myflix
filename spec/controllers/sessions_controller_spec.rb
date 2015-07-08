require 'spec_helper'

describe SessionsController do 
  describe 'GET new' do 
    it 'render new template if not logged in' do 
      get 'new'
      expect(response).to render_template :new
    end

    it 'redirect_to home_path if logged in' do 
      session[:user_id] = Fabricate(:user).id
      get 'new'
      expect(response).to redirect_to home_path
    end

  end
  describe 'POST create' do 

    let(:mark) {Fabricate(:user)}

    context 'user is authenticated' do
      before do 
        post 'create', email: mark.email, password: mark.password
      end

      it 'sets session[:user_id]' do 
        expect(session[:user_id]).to eq(mark.id)
      end

      it 'shows flash notice' do 
        expect(flash[:success]).not_to be_blank        
      end

      it 'redirect_to home_path' do
        expect(response).to redirect_to home_path  
      end

    end

    context 'user is not authenticated' do 
      before do 
        post 'create', email: mark.email, password: 'wrong password'
      end

      it 'do not sets session[:user_id]' do 
        expect(session[:user_id]).to be_nil
      end

      it 'shows flash notice' do 
        expect(flash[:danger]).not_to be_blank
      end

      it 'render new template' do 
        expect(response).to render_template :new
      end

    end 
  end

  describe 'GET destroy' do 
    before do 
      session[:user_id] = Fabricate(:user).id
      get 'destroy'
    end

    it 'clear the session' do 
      expect(session[:user_id]).to be_nil
    end

    it 'shows flach warning' do 
      expect(flash[:warning]).not_to be_blank
    end
    
    it 'redirect to front_video_path' do 
      expect(response).to redirect_to front_videos_path
    end 
  end
  
end