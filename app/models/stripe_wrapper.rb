module StripeWrapper
  class Charge

    attr_reader :response, :status

    def initialize(response, status)
      @response = response
      @status = status
    end

    def self.create(option={}) # parameters: source, user, amount, description
      begin
        customer = StripeWrapper::Customer.create(option[:source], option[:user])
        response = Stripe::Charge.create(
          amount: option[:amount], 
          currency: 'usd', 
          customer: customer.id,
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

    def self.create(token, user)
      Stripe::Customer.create(
        :source => token,
        :plan => "base",
        :email => user.email
      )
    end
  end
end