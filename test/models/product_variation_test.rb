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
require 'test_helper'

class ProductVariationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
