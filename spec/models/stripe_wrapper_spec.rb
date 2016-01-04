require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do
      before do 
        StripeWrapper::Charge.set_api_key
      end

      let (:token) do 
        Stripe::Token.create(
          :card => {
            :number => "4242424242424242",
            :exp_month => 12,
            :exp_year => 2020,
            :cvc => "314"
          },
        ).id
      end

      it 'makes a successful charge', :vcr do 
        charge = StripeWrapper::Charge.create(
            amount: 999,
            source: token,
            description: 'this is a valid charge'
          )

        expect(charge.response.amount).to eq(999)
      end
    end
  end
  
end