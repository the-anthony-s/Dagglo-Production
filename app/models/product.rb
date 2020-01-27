# == Schema Information
#
# Table name: products
#
#  id                    :bigint           not null, primary key
#  name                  :string
#  barcode               :string
#  about                 :text
#  country               :string
#  min_price             :money
#  num_offers            :integer
#  manufacturer_warranty :boolean
#  status                :integer          default("pending")
#  image_data            :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  category_id           :bigint
#  owner_user_id         :bigint
#  owner_seller_id       :bigint
#  slug                  :string
#

class Product < ApplicationRecord

  # Custom IDs for URLs
  extend FriendlyId
  friendly_id :name, use: :slugged, :use => :history



  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil },
          recipient: Proc.new { |controller, model| controller.user_seller_account ? controller.user_seller_account : nil }



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
