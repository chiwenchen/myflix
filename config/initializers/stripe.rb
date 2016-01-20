StripeWrapper::Charge.set_api_key

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
    Payment.create
    binding.pry
  end

  # events.all do |event|
  #   Handle all event types - logging, etc.
  # end
end