class SellerProduct < ApplicationRecord


  belongs_to :seller, :foreign_key => 'seller_id'
  belongs_to :product, :foreign_key => 'product_id'


  validates_presence_of :product_id


end
