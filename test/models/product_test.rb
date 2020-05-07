# == Schema Information
#
# Table name: products
#
#  id                 :bigint           not null, primary key
#  name               :string
#  description        :text
#  variations         :hstore
#  country_code       :string
#  barcode            :string
#  status             :integer          default("pending")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  category_id        :bigint
#  owner_user_id      :bigint
#  owner_seller_id    :bigint
#  deleted_at         :datetime
#  views              :integer
#  slug               :string
#  product_barcode_id :bigint
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
