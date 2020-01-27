# == Schema Information
#
# Table name: seller_locations
#
#  id         :bigint           not null, primary key
#  name       :string
#  street     :string
#  city       :string
#  zip        :string
#  state      :string
#  country    :string
#  longitude  :float
#  latitude   :float
#  phone      :string
#  pause      :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  seller_id  :bigint
#

require 'test_helper'

class SellerLocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
