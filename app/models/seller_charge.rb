# == Schema Information
#
# Table name: seller_charges
#
#  id              :bigint           not null, primary key
#  seller_id       :bigint           not null
#  stripe_id       :string
#  amount          :integer
#  amount_refunded :integer
#  card_brand      :string
#  card_last4      :string
#  card_exp_month  :string
#  card_exp_year   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class SellerCharge < ApplicationRecord

  acts_as_paranoid
  
  # include PublicActivity::Model
  # tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil },
  #         recipient: Proc.new { |controller, model| controller.user_seller_account ? controller.user_seller_account : nil }
  
  
  belongs_to :seller


  scope :sorted, -> { order(created_at: :desc) }
  default_scope -> { sorted }

  def filename
    "Dagglo_Receipt_#{created_at.strftime("%Y_%m_%d")}.pdf"
  end

  def receipt
    Receipts::Receipt.new(
      id: id,
      product: "Dagglo Seller Subscription",
      company: {
        name: "Dagglo Inc",
        address: "3880 Duke of York Blvd\nMississauga, ON\nCanada",
        email: "help@dagglo.com"
      },
      line_items: line_items
    )
  end

  def line_items
    [
      ["Date", created_at.to_s],
      ["Account Billed", "#{seller.owner.full_name} (#{seller.owner.email})"],
      ["Product", "Dagglo Seller Subscription for #{seller.name}"],
      ["Amount", ApplicationController.helpers.formatted_amount(amount)],
      ["Charged to", "#{card_brand} ending in **** **** **** #{card_last4}"]
    ]

    # line_items << ["Amount Refunded", ApplicationController.helpers.formatted_amount(amount)] if amount_refunded?
    # line_items
  end

  def refund(amount: nil)
    Stripe::Refund.create(charge: stripe_id, amount: amount)
    update(amount_refunded: amount)
  end

end
