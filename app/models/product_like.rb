# == Schema Information
#
# Table name: product_likes
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
class ProductLike < ApplicationRecord
    belongs_to :user
    belongs_to :product
end
