class SellerMailer < ApplicationMailer

  def payment_action_required(seller, payment_intent, seller_subscription)
    @seller = seller
    @payment_intent = payment_intent
    @seller_subscription = seller_subscription

    mail to: @seller.owner.email, subject: "Payment confirmation required"
  end

end