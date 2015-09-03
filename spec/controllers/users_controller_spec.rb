require 'spec_helper'

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
    context '@user is authenticated' do
      it 'saves @user' do 
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end

      it 'redirect_to home_path' do 
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to home_path
      end

      it "sets the invitation if have invitation" do 
        @invitation = Fabricate(:invitation)
        post :create, user: Fabricate.attributes_for(:user), invitation_token: @invitation.token
        expect(assigns(:invitation)).to be_present
      end
      it "makes the new user follow the inviter" do 
        @invitation = Fabricate(:invitation)
        post :create, user: Fabricate.attributes_for(:user), invitation_token: @invitation.token
        expect(assigns(:user).followed?(User.find(@invitation.inviter_id))).to be_true
      end
      it "makes the inviter follow the new user" do 
        @invitation = Fabricate(:invitation)
        post :create, user: Fabricate.attributes_for(:user), invitation_token: @invitation.token
        expect(User.find(@invitation.inviter_id).followed?(assigns(:user))).to be_true
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

    context 'sends mail' do 
      after{ActionMailer::Base.deliveries.clear}

      it 'sends out the email' do 
        post :create, user: Fabricate.attributes_for(:user, name: 'sammy')
        expect(ActionMailer::Base.deliveries.last).should_not be_blank
      end
      it 'sends the email to the right person' do 
        sammy = Fabricate.attributes_for(:user, name: 'sammy')
        post :create, user: sammy
        expect(ActionMailer::Base.deliveries.last.to).to eq([sammy[:email]])
      end
      it 'sends out the correct context' do 
        sammy = Fabricate.attributes_for(:user, name: 'sammy')
        post :create, user: sammy
        expect(ActionMailer::Base.deliveries.last.body).to include("Welcome to the Myflix, sammy", "Enjoy the videos")
      end

      it 'does not sends out the mail if the register input is not valid' do 
        carol = Fabricate.attributes_for(:user, name: nil, password: nil)
        post :create, user: carol
        expect(ActionMailer::Base.deliveries.last).should be_blank
      end
    end

  end
end