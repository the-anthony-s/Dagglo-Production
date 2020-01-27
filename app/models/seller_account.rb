# == Schema Information
#
# Table name: seller_accounts
#
#  id                 :bigint           not null, primary key
#  role               :integer
#  owner              :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint
#  seller_id          :bigint
#  seller_location_id :bigint
#

class SellerAccount < ApplicationRecord
  
  belongs_to :user
  belongs_to :seller
  belongs_to :seller_locaion, optional: true
  
end
