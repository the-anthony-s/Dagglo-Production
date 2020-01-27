# == Schema Information
#
# Table name: seller_plans
#
#  id         :bigint           not null, primary key
#  name       :string
#  amount     :integer
#  interval   :string
#  stripe_id  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SellerPlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
