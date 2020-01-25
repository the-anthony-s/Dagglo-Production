class Seller < ApplicationRecord

  # Onboarding steps
  include SellerOnboarding
  


  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil },
          recipient: Proc.new { |controller, model| controller.user_seller_account ? controller.user_seller_account : nil }



  # Custom IDs for URLs
  extend FriendlyId
  friendly_id :name, use: :slugged, :use => :history



  belongs_to :owner, class_name: "User"

  has_many :seller_accounts, dependent: :delete_all
  has_many :seller_products, dependent: :delete_all



  # Mandatory fields
  validates_presence_of :name



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



  # Return Seller Logo
  def logo(height = nil, width = nil)
    if image_data.present?
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
  def cover(height = nil, width = nil)
    ActionController::Base.helpers.asset_path("defaults/" + ["image.png"].compact.join('_'))
  end

end
