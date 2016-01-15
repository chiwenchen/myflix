require 'spec_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe UsersController do 
  describe "GET new" do 
    it "sets @user" do 
      get :new
      expect(assigns(:user)).to be_an_instance_of(User)
    end
  end

  describe "GET new_with_invitation" do 
    it "sets the user with passing in invitee email" do 
      @invitation = Fabricate(:invitation)
      get :new_with_invitation, invitation: @invitation.token
      expect(assigns(:user).email).to eq(@invitation.invitee_email)
    end
    it "render the new template" do 
      @invitation = Fabricate(:invitation)
      get :new_with_invitation, invitation: @invitation.token
      expect(response).to render_template :new
    end
    it "logged in if current_user is exist" do 
      set_current_user
      @invitation = Fabricate(:invitation)
      get :new_with_invitation, invitation: @invitation.token
      expect(response).to redirect_to home_path
    end

  end

  describe "POST create" do 
    context 'common behavior' do 
      it "sets the flash message" do 
        result = double('result', status: 'status', message: 'this is a message')
        result.should_receive(:successful?).and_return(true)
        SignUpService.any_instance.should_receive(:signup).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
        expect(flash[result.status]).to eq(result.message)
      end
    end
    context 'successfully sign up' do 
      it "redirect_to home path" do 
        result = double('result', status: :success, message: 'sign up successfully')
        result.should_receive(:successful?).and_return(true)
        SignUpService.any_instance.should_receive(:signup).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to home_path
      end 
    end
    context 'sign up failure' do 
      it 'render the new template' do 
        result = double('result', status: :success, message: 'sign up successfully')
        result.should_receive(:successful?).and_return(false)
        SignUpService.any_instance.should_receive(:signup).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to render_template :new
      end
    end

  end
end