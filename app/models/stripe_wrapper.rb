module StripeWrapper
  class Charge

    attr_reader :response, :status

    def initialize(response, status)
      @response = response
      @status = status
    end

    def self.create(option={}) # parameters: source, user, amount, description
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

    def basic_plan
      Stripe::Plan.create(
        :amount => 999,
        :interval => 'month',
        :name => 'Monthly pay',
        :currency => 'usd',
        :id => 'basic'
      )
    end
  end

  class Customer 

    attr_reader :response, :error_message

    def initialize(response, error_message)
      @response = response
      @error_message = error_message
    end

    def self.create(token, user)
      begin
        response = Stripe::Customer.create(
          :source => token,
          :plan => "base"
        )
        new(response, nil)
      rescue Stripe::CardError => e
        new(response, e.message)
      end
    end

    def successful?
      error_message == nil
    end

  end

end