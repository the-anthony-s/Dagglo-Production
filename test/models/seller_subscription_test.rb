# == Schema Information
#
# Table name: seller_subscriptions
#
#  id            :bigint           not null, primary key
#  seller_id     :bigint           not null
#  stripe_id     :string
#  stripe_plan   :string
#  status        :string
#  trial_ends_at :datetime
#  ends_at       :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class SellerSubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
