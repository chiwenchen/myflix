require 'spec_helper'

describe RelationshipsController do 
  describe "Get index" do 
    it 'require user' do 
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to front_videos_path
    end

    context 'user is authenticated' do 

      before do 
        set_current_user
      end

      it 'sets @relationships as the array collection of all followed leader' do 
        bob = Fabricate(:user)
        relationship = Fabricate(:relationship, leader: bob, follower: sammy)
        get :index
        expect(assigns(:relationships)).to eq([relationship])
      end

      it 'render index template' do 
        get :index
        expect(response).to render_template :index
      end
    end
  end
end