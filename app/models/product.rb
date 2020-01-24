class Product < ApplicationRecord


  # Custom IDs for URLs
  extend FriendlyId
  friendly_id :name, use: :slugged, :use => :history


  # belongs_to :category, :foreign_key => 'category_id'
  belongs_to :owner_user, optional: true, class_name: "User"
  belongs_to :owner_seller, optional: true, class_name: "Seller"

  has_many :seller_products, dependent: :delete_all
  has_many :sellers, :through => :seller_products


  # Mandatory fields
  validates :name, presence: true
  validates :barcode, presence: true
  # validates :category_id, presence: true



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



  # Get product first photo
  def photo(height = nil, width = nil)
    if image_data.present?
      if height != nil && width != nil
        image.derivation_url(:thumbnail, height, width).to_s
      else
        image.url
      end
    else
      ActionController::Base.helpers.asset_path("defaults/" + ["product.png"].compact.join('_'))
    end
  end


end
