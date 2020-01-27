# == Schema Information
#
# Table name: seller_products
#
#  id                      :bigint           not null, primary key
#  unit_price              :money
#  min_order_price         :money
#  sku                     :string(10)
#  harmonized_system_code  :string
#  country_code_of_origin  :string
#  province_code_of_origin :string
#  barcode                 :string
#  packaging               :string
#  packaging_details       :text
#  shelf_life              :string
#  supply_ability          :string
#  weight                  :string
#  status                  :string
#  pause                   :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  product_id              :bigint
#  seller_id               :bigint
#

require 'test_helper'

class SellerProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
