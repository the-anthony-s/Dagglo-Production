class Product < ApplicationRecord


  # Custom IDs for URLs
  extend FriendlyId
  friendly_id :name, use: :slugged, :use => :history


  belongs_to :category, :foreign_key => 'category_id'
  belongs_to :owner_user, optional: true, class_name: "User"
  belongs_to :owner_seller, optional: true, class_name: "Seller"

  has_many :seller_products, dependent: :delete_all
  has_many :sellers, :through => :seller_products


  # Mandatory fields
  validates_presence_of :barcode
  validates_presence_of :category_id
  validates_presence_of :title


end
