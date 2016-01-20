require 'spec_helper'

describe StripeWrapper do
  before {StripeWrapper::Charge.set_api_key}

  let (:valid_token) do 
    Stripe::Token.create(
      :card => {
        :number => "4242424242424242",
        :exp_month => 12,
        :exp_year => 2020,
        :cvc => "314"
      },
    ).id
  end

  let(:alice){Fabricate(:user)}

  describe StripeWrapper::Charge do
    describe ".create" do

      it 'makes a successful charge', :vcr do 
        charge = StripeWrapper::Charge.create(
            amount: 999,
            source: valid_token,
            user: alice,
            description: 'this is a valid charge'
          )
        expect(charge.response.amount).to eq(999)
      end

    end
  end

  describe StripeWrapper::Customer do 
    describe ".create" do 
      it 'creates a customer' , :vcr do 
        customer = StripeWrapper::Customer.create(valid_token, alice)
        expect(customer.id).to be_present
      end
    end
  end
  
end