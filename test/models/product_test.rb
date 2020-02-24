# == Schema Information
#
# Table name: products
#
#  id                    :bigint           not null, primary key
#  name                  :string
#  barcode               :string
#  about                 :text
#  country               :string
#  min_price             :money
#  num_offers            :integer
#  manufacturer_warranty :boolean
#  status                :integer          default("0")
#  image_data            :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  category_id           :bigint
#  owner_user_id         :bigint
#  owner_seller_id       :bigint
#  slug                  :string
#  deleted_at            :datetime
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
