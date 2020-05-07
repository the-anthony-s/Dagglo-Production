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
#  deleted_at :datetime
#

class SellerLocation < ApplicationRecord

  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil },
          recipient: Proc.new { |controller, model| controller.user_seller_account ? controller.user_seller_account : nil }


  has_many :seller_accounts

  belongs_to :seller, :foreign_key => 'seller_id'



  # Must have values
  validates :name, uniqueness: true, presence: true



  # Geocode gem
  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  def address
    [address_1, address_2, city, zip, country, state].compact.join(', ')
  end

  def address_changed?
    address_1_changed? || address_2_changed? || city_changed? || zip_changed? || state_changed? || country_changed?
  end
end
