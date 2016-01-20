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

  let (:invalid_token) do 
    Stripe::Token.create(
      :card => {
        :number => "4000000000000002",
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
        expect(customer.response.id).to be_present
      end

      it 'does not create a customer if the token is invalid', :vcr do 
        customer = StripeWrapper::Customer.create(invalid_token, alice)
        expect(customer.response).to be_nil
      end

      it 'sets error message if the token is invalid', :vcr do 
        customer = StripeWrapper::Customer.create(invalid_token, alice)
        expect(customer.error_message).to eq("Your card was declined.")
      end

    end
  end
  
end