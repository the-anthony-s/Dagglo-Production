# == Schema Information
#
# Table name: product_barcodes
#
#  id           :bigint           not null, primary key
#  barcode      :string
#  gtin14       :string
#  ean13        :string
#  upc          :string
#  prefix       :string
#  prefix_name  :string
#  country_code :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_id   :bigint
#
require 'test_helper'

class ProductBarcodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
