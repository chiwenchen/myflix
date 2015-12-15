module StripeWrapper
  class Charge
    def self.create(option={})
      Stripe::Charge.create(
        amount: option[:amount], 
        currency: 'usd', 
        source: option[:source],
        description: option[:description]
      )
    end

    def self.set_api_key
      Stripe.api_key = ENV['SECRET_KEY']
    end
  end
end