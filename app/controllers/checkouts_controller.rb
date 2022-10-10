class CheckoutsController < ApplicationController
  def show
    current_user.payment_processor.customer

    @checkout_session = current_user.payment_processor.checkout(
      mode: "payment",
      line_items: "price_1KGBFmL1sbzE61KCcRUkZ9lh",
      success_url: "http://localhost:3000/checkout/success?session_id={CHECKOUT_SESSION_ID}",
    )
  end

  def success
    @success_response = params
  end
end
