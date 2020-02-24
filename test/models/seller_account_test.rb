# == Schema Information
#
# Table name: seller_accounts
#
#  id                 :bigint           not null, primary key
#  role               :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint
#  seller_id          :bigint
#  seller_location_id :bigint
#  deleted_at         :datetime
#

require 'test_helper'

class SellerAccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
