class SellerChargeRefundedWebhook
  def call(event)
    object = event.data.object
    user = Seller.find_by(stripe_id: object.customer)
    return if user.nil?

    charge = user.seller_charges.find_by(stripe_id: object.id)
    return if charge.nil?

    charge.update(amount_refunded: object.amount_refunded)
  end
end
