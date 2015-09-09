require 'spec_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe InvitationsController do 
  describe "post Create" do 
    context "with valid input" do
      before do 
        set_current_user
        post :create, invitation: {invitee_name: 'Chiwen', invitee_email: 'chiwen@example.com', message: 'join MyFlix!!'}
      end

      after {ActionMailer::Base.deliveries.clear}

      it "redirect to home page" do 
        expect(response).to redirect_to home_path
      end
      it "sets the @invitation" do 
        expect(assigns(:invitation)).to be_instance_of Invitation
      end
      it "saves the invitation" do 
        expect(Invitation.count).to eq(1)
      end
      it "shows the successful invited notice" do 
        expect(flash[:success]).to be_present
      end
      it "sends out the invitation email to the invitee's email" do 
        expect(ActionMailer::Base.deliveries.last.to).to eq(["chiwen@example.com"])
      end
      it "generates the token" do 
        expect(Invitation.first.token).to be_present
      end
    end

    context "with invalid input" do 
      before do 
        set_current_user
        post :create, invitation: {invitee_email: 'chiwen@example.com', message: 'join MyFlix!!'}
      end
      
      after {ActionMailer::Base.deliveries.clear}

      it "does not save the invitation" do 
        expect(Invitation.count).to eq(0)
      end
      it "shows the error message" do 
        expect(flash[:danger]).to be_present
      end
      it "render the new template" do 
        expect(response).to render_template :new
      end
      it "does not send out the email" do 
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end

    end
  end
end