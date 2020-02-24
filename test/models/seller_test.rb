# == Schema Information
#
# Table name: sellers
#
#  id                      :bigint           not null, primary key
#  name                    :string
#  business_number         :string
#  about                   :text
#  country                 :string
#  founding_date           :date
#  status                  :integer          default("0")
#  private                 :boolean          default("false")
#  image_data              :text
#  cover_data              :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  slug                    :string
#  onboarding_completed_at :datetime
#  stripe_id               :string
#  card_brand              :string
#  card_last4              :string
#  card_exp_month          :string
#  card_exp_year           :string
#  deleted_at              :datetime
#

require 'test_helper'

class SellerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
