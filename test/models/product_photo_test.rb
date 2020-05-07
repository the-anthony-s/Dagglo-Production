# == Schema Information
#
# Table name: product_photos
#
#  id         :bigint           not null, primary key
#  product_id :bigint
#  image_data :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ProductPhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
