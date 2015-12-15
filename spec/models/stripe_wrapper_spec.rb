require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do

      it 'makes a successful charge' do 
        StripeWrapper::Charge.set_api_key
        token = Stripe::Token.create(
          :card => {
            :number => "4242424242424242",
            :exp_month => 12,
            :exp_year => 2020,
            :cvc => "314"
          },
        ).id

        response = StripeWrapper::Charge.create(
            amount: 999,
            source: token,
            description: 'this is a valid charge'
          )
        expect(response.amount).to eq(999)
      end
    end
  end
  
end