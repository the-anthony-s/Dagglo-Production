class Seller < ApplicationRecord


  # Custom IDs for URLs
  extend FriendlyId
  friendly_id :name, use: :slugged, :use => :history



  belongs_to :owner, class_name: "User"

  has_many :seller_accounts, dependent: :delete_all
  has_many :seller_products, dependent: :delete_all



  # Mandatory fields
  validates_presence_of :name


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
