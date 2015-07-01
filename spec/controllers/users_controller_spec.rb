require 'spec_helper'

describe UsersController do 
  describe "GET new" do 
    it "sets @user" do 
      get :new
      expect(assigns(:user)).to be_an_instance_of(User)
    end
  end

  describe "POST create" do 
    context '@user is authenticated' do
      # before do 
      #   let(:alpha) {Fabricate(:user)}
      # end
      it 'saves @user' do 
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end
      it 'redirect_to home_path' do 
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to home_path
      end
    end

    context '@user is not authenticated' do 
      it 'do not save @user' do 
        post :create, user: {password: 'password', name: 'Saya'}
        expect(User.count).to eq(0)
      end
      it 'render new template' do
        post :create, user: {password: 'password', name: 'Saya'}
        expect(response).to render_template :new
      end
      it 'sets @user' do 
        post :create, user: {password: 'password', name: 'Saya'}
        expect(assigns(:user)).to be_an_instance_of(User)
      end
    end
  end

end