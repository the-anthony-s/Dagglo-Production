# == Schema Information
#
# Table name: seller_plans
#
#  id                  :bigint           not null, primary key
#  name                :string
#  amount              :integer
#  interval            :string
#  stripe_id           :string
#  num_of_products     :integer
#  num_of_locations    :integer
#  num_of_sub_accounts :integer
#  analytics           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class SellerPlan < ApplicationRecord

  # Scopes
  scope :is_active, -> { where(pause: false) }

end
