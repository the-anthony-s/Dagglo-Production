# == Schema Information
#
# Table name: seller_charges
#
#  id              :bigint           not null, primary key
#  seller_id       :bigint           not null
#  stripe_id       :string
#  amount          :integer
#  amount_refunded :integer
#  card_brand      :string
#  card_last4      :string
#  card_exp_month  :string
#  card_exp_year   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class SellerChargeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
