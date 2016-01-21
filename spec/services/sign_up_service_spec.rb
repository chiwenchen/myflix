require 'spec_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe SignUpService do 
  describe "#sign_up" do
    context 'valid personal info and credit card' do
      let(:customer) {double('customer', customer_token: 'abcd')}
      let(:mark) {Fabricate.build(:user)}
      before do 
        customer.stub(:successful?).and_return(true)
        StripeWrapper::Customer.stub(:create).and_return(customer) 
      end

      after{ActionMailer::Base.deliveries.clear}

      it "charges the credit card" do 
        SignUpService.new(mark).signup('stripe_token')
        expect((customer).successful?).to be_truthy
      end

      it 'saves @user' do 
        SignUpService.new(mark).signup('stripe_token')
        expect(User.count).to eq(1)
      end

      it 'sets the customer_token to user' do 
        SignUpService.new(mark).signup('stripe_token')
        expect(User.first.customer_token).to be_present
      end

      it "sends out the mail" do 
        SignUpService.new(mark).signup('stripe_token')
        expect(ActionMailer::Base.deliveries.last).to be_present
      end

      it "makes the new user follow the inviter and verse visa" do 
        @invitation = Fabricate(:invitation)
        SignUpService.new(mark).signup('stripe_token', @invitation.token)
        expect(mark.followed?(User.find(@invitation.inviter_id))).to be_truthy
        expect(User.find(@invitation.inviter_id).followed?(mark)).to be_truthy
      end
    end

    context 'invalid personal info' do 
      let(:customer) {double('customer')}
      let(:mark) {Fabricate.build(:user, name: nil)}
      before do 
        customer.stub(:successful?).and_return(true)
        StripeWrapper::Charge.stub(:create).and_return(customer) 
      end

      it 'does not create new user' do 
        SignUpService.new(mark).signup('stripe_token')
        expect(User.count).to eq(0)
      end

      it 'sets the status and message' do 
        signup = SignUpService.new(mark).signup('stripe_token')
        expect(signup.status).to eq(:warning)
        expect(signup.message).to eq('user info is not valid, please fullfil the column highlighted')
      end

      it 'does not sends out mail' do 
        SignUpService.new(mark).signup('stripe_token')
        expect(ActionMailer::Base.deliveries.last).to be_blank
      end
    end

    context 'valid personal info and invalid credit card' do 
      let(:customer) {double('customer')}
      let(:mark) {Fabricate.build(:user, name: nil)}
      before do 
        customer.stub(:successful?).and_return(true)
        StripeWrapper::Charge.stub(:create).and_return(customer) 
      end

      it 'does not create new user' do 
        SignUpService.new(mark).signup('stripe_token')
        expect(User.count).to eq(0)
      end

      it 'sets the status and message' do 
        signup = SignUpService.new(mark).signup('stripe_token')
        expect(signup.status).to eq(:warning)
        expect(signup.message).to eq(signup.message)
      end

      it 'does not sends out mail' do 
        SignUpService.new(mark).signup('stripe_token')
        expect(ActionMailer::Base.deliveries.last).to be_blank
      end
    end
  end
end