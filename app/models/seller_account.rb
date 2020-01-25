class SellerAccount < ApplicationRecord
  
  belongs_to :user
  belongs_to :seller
  belongs_to :seller_locaion, optional: true
  
end
