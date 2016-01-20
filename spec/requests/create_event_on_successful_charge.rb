require 'spec_helper'

describe "create event on successful charge", :vcr do
  let(:event_object){
    {
      "id" => "evt_17VGozK6bLvHx8bURNGsvaJh",
      "object" => "event",
      "api_version" => "2015-10-16",
      "created" => 1453276565,
      "data" => {
        "object" => {
          "id" => "ch_17VGozK6bLvHx8bUMIV7chvK",
          "object" => "charge",
          "amount" => 999,
          "amount_refunded" => 0,
          "application_fee" => nil,
          "balance_transaction" => "txn_17VGozK6bLvHx8bUbnbhyRrG",
          "captured" => true,
          "created" => 1453276565,
          "currency" => "usd",
          "customer" => "cus_7kmNk9Zw15oi4B",
          "description" => nil,
          "destination" => nil,
          "dispute" => nil,
          "failure_code" => nil,
          "failure_message" => nil,
          "fraud_details" => {},
          "invoice" => "in_17VGozK6bLvHx8bUBVjff7fx",
          "livemode" => false,
          "metadata" => {},
          "order" => nil,
          "paid" => true,
          "receipt_email" => nil,
          "receipt_number" => nil,
          "refunded" => false,
          "refunds" => {
            "object" => "list",
            "data" => [],
            "has_more" => false,
            "total_count" => 0,
            "url" => "/v1/charges/ch_17VGozK6bLvHx8bUMIV7chvK/refunds"
          },
          "shipping" => nil,
          "source" => {
            "id" => "card_17VGoxK6bLvHx8bUD0T2WlUc",
            "object" => "card",
            "address_city" => nil,
            "address_country" => nil,
            "address_line1" => nil,
            "address_line1_check" => nil,
            "address_line2" => nil,
            "address_state" => nil,
            "address_zip" => nil,
            "address_zip_check" => nil,
            "brand" => "Visa",
            "country" => "US",
            "customer" => "cus_7kmNk9Zw15oi4B",
            "cvc_check" => "pass",
            "dynamic_last4" => nil,
            "exp_month" => 1,
            "exp_year" => 2019,
            "fingerprint" => "faS4loXvHw0MNPP7",
            "funding" => "credit",
            "last4" => "4242",
            "metadata" => {},
            "name" => nil,
            "tokenization_method" => nil
          },
          "statement_descriptor" => nil,
          "status" => "succeeded"
        }
      },
      "livemode" => false,
      "pending_webhooks" => 1,
      "request" => "req_7kmN02UKm5qR2w",
      "type" => "charge.succeeded"
    }
  }

  it "create a payment event with successfule charge" do 
    post '/stripe_events', event_object
    expect(Payment.count).to eq(1)
  end
  
end