# == Schema Information
#
# Table name: product_variations
#
#  id          :bigint           not null, primary key
#  name        :string
#  field_type  :string
#  required    :boolean
#  category_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ProductVariation < ApplicationRecord

    belongs_to :category

end
