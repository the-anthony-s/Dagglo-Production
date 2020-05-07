# == Schema Information
#
# Table name: sellers
#
#  id                      :bigint           not null, primary key
#  name                    :string
#  business_number         :string
#  description             :text
#  country                 :string
#  founding_date           :date
#  status                  :integer          default("pending")
#  private                 :boolean          default(FALSE)
#  image_data              :text
#  cover_data              :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  owner_id                :bigint
#  onboarding_completed_at :datetime
#  stripe_id               :string
#  card_brand              :string
#  card_last4              :string
#  card_exp_month          :string
#  card_exp_year           :string
#  deleted_at              :datetime
#  views                   :integer
#  slug                    :string
#

class Seller < ApplicationRecord

  acts_as_paranoid
  

  # Onboarding steps
  include SellerOnboarding

  # Track Views
  is_impressionable counter_cache: true, column_name: :views


  # include PublicActivity::Model
  # tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil },
  #         recipient: Proc.new { |controller, model| controller.user_seller_account ? controller.user_seller_account : nil }



  # Custom IDs for URLs
  extend FriendlyId
  friendly_id :name, use: :slugged, :use => :history


  # Relationships
  belongs_to :owner, class_name: "User"
  
  has_many :seller_accounts, dependent: :delete_all
  # has_many :users, through: :seller_accounts
  has_many :seller_products, dependent: :delete_all
  has_many :seller_locations, dependent: :delete_all
  has_many :seller_subscriptions, dependent: :delete_all
  has_many :seller_charges



  # Mandatory fields
  validates_presence_of :name



  # Scopes
  scope :is_public, -> { where(private: false, status: 1) }



  # Product statuses
  enum status: {
    pending: 0,
    active: 1,
    paused: 2,
    banned: 3
  }

  def get_status
    status
  end


  # Date formatting
  def member_since
    created_at.strftime("%b %d, %Y")
  end


  # Images configuration
  include ImageUploader::Attachment(:image)

  def logo(height = nil, width = nil)
    if image.present?
      if height != nil && width != nil
        image.derivation_url(:thumbnail, height, width).to_s
      else
        image.url
      end
    else
      ActionController::Base.helpers.asset_path("defaults/" + ["logo.png"].compact.join('_'))
    end
  end



  # Return Seller Cover Image
  include ImageUploader::Attachment(:cover)

  def background(height = nil, width = nil)
    if cover.present?
      if height != nil && width != nil
        cover.derivation_url(:thumbnail, height, width).to_s
      else
        cover.url
      end
    else
      ActionController::Base.helpers.asset_path("defaults/" + ["image.png"].compact.join('_'))
    end
  end



  # Subscription
  def subscribed?
    subscription && subscription.active?
  end

  def subscription
    seller_subscriptions.last
  end

  def subscribe(plan, options={})
    stripe_customer if !stripe_id?

    args = {
      customer: stripe_id,
      items: [{ plan: plan }],
      expand: ['latest_invoice.payment_intent'],
      off_session: true,
    }.merge(options)

    args[:trial_from_plan] = true if !args[:trial_period_days]

    sub = Stripe::Subscription.create(args)

    subscription = seller_subscriptions.create(
      stripe_id: sub.id,
      stripe_plan: plan,
      status: sub.status,
      trial_ends_at: (sub.trial_end ? Time.at(sub.trial_end) : nil),
      ends_at: nil,
    )

    if sub.status == "incomplete" && ["requires_action", "requires_payment_method"].include?(sub.latest_invoice.payment_intent.status)
      raise PaymentIncomplete.new(sub.latest_invoice.payment_intent), "Subscription requires authentication"
    end

    subscription
  end

  def create_setup_intent
    stripe_customer if !stripe_id
    Stripe::SetupIntent.create(customer: stripe_id)
  end

  def update_seller_card(payment_method_id)
    stripe_customer if !stripe_id?

    payment_method = Stripe::PaymentMethod.attach(payment_method_id, { customer: stripe_id })
    Stripe::Customer.update(stripe_id, invoice_settings: { default_payment_method: payment_method.id })

    update(
      card_brand: payment_method.card.brand.titleize,
      card_last4: payment_method.card.last4,
      card_exp_month: payment_method.card.exp_month,
      card_exp_year: payment_method.card.exp_year,
    )
  end

  def stripe_customer
    if stripe_id
      Stripe::Customer.retrieve(stripe_id)
    else
      customer = Stripe::Customer.create(
        email: owner.email,
        name: owner.full_name
      )
      update(stripe_id: customer.id)
      customer
    end
  end

  def credit_card_icon
    if card_brand == "Visa"
      "cc-visa"
    elsif card_brand == "Mastercard"
      "cc-mastercard"
    elsif card_brand == "Amex"
      "cc-amex"
    elsif card_brand == "Discover"
      "cc-discover"
    elsif card_brand == "Diners Club"
      "cc-diners-club"
    elsif card_brand == "JCB"
      "cc-jcb"
    else
      "credit-card"
    end
  end

end
