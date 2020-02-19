Stripe.api_key = Rails.application.credentials[Rails.env.to_sym][:stripe][:private_key]

class PaymentIncomplete < StandardError
  attr_reader :payment_intent

  def initialize(payment_intent)
    @payment_intent = payment_intent
  end

end


StripeEvent.signing_secret = ENV['STRIPE_SIGNING_SECRET'] || Rails.application.credentials[Rails.env.to_sym][:stripe][:signing_secret]
StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', SellerChargeSucceededWebhook.new
  events.subscribe 'charge.refunded', SellerChargeRefundedWebhook.new
  events.subscribe 'customer.subscription.updated', SellerSubscriptionUpdatedWebhook.new
  events.subscribe 'customer.subscription.deleted', SellerSubscriptionDeletedWebhook.new
  events.subscribe 'invoice.payment_action_required', SellerPaymentActionRequiredWebhook.new
end
