StripeWrapper::Charge.set_api_key

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
    customer = User.find_by(customer_token: event.data.object.customer)
    Payment.create(user: customer, amount: event.data.object.amount, reference_id: event.data.object.id)
  end

  # events.all do |event|
  #   Handle all event types - logging, etc.
  # end
end