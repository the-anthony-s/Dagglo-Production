class SellerPaymentActionRequiredWebhook
  def call(event)
    object = event.data.object
    user = Seller.find_by(stripe_id: object.customer)
    subscription = SellerSubscription.find_by(stripe_id: object.subscription)

    return if user.nil? || subscription.nil?

    SellerMailer.payment_action_required(user, object.payment_intent, subscription).deliver_later
  end
end
