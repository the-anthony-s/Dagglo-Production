# == Schema Information
#
# Table name: seller_accounts
#
#  id                 :bigint           not null, primary key
#  role               :integer
#  owner              :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint
#  seller_id          :bigint
#  seller_location_id :bigint
#

class SellerAccount < ApplicationRecord

  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil },
          recipient: Proc.new { |controller, model| controller.user_seller_account ? controller.user_seller_account : nil }


  belongs_to :user
  belongs_to :seller
  belongs_to :seller_locaion, optional: true


  before_validation :set_user_id, if: :email?
  attribute :email, :string

  def set_user_id
    self.user = User.invite!(email: email)
  end


  # Roles
  enum role: {
    owner: 0,
    manager: 1
  }

  def get_role
    role
  end

end
