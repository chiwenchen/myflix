module StripeWrapper
  class Charge

    attr_reader :response, :status

    def initialize(response, status)
      @response = response
      @status = status
    end

    def self.create(option={})
      begin
        response = Stripe::Charge.create(
          amount: option[:amount], 
          currency: 'usd', 
          source: option[:source],
          description: option[:description]
        )
        new(response, :success)
      rescue Stripe::CardError => e
        new(e.message, :false)
      end
    end

    def successful?
      self.status == :success
    end

    def self.set_api_key
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    end
  end
end