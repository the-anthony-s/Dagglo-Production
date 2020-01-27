class PaymentActionRequiredPreview < ApplicationMailer::Preview

  def payment_action_required
    seller = Seller.new(email: "test@gmail.com", name: "Test, LLC")
    seller_subscription = SellerSubscription.new
    payment_intent = Stripe::PaymentIntent.retrieve("sk_test_cbWpn6dFB3TA8aRVzk5qdVJU")

    SellerMailer.payment_action_required(seller, payment_intent, seller_subscription)
  end

end