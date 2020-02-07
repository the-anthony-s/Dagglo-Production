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

class SellerLocation < ApplicationRecord

  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil },
          recipient: Proc.new { |controller, model| controller.user_seller_account ? controller.user_seller_account : nil }




  has_many :seller_accounts

  belongs_to :seller, :foreign_key => 'seller_id'



  # Must have values
  validates_presence_of :name



  # Geocode gem
  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  def address
    [street, city, zip, country, state].compact.join(', ')
  end

  def address_changed?
    street_changed? || city_changed? || zip_changed? || state_changed? || country_changed?
  end



  # Location screenshot
  # if Google Maps work -> Return screenshot
  # else -> Return placeholder
  def map_photo
    if longitude.present? && latitude.present?
      "http://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&markers=#{latitude},#{longitude}&zoom=15&size=120x120&key=AIzaSyAfioIw_NiEIej4B-jmqT06gOTZv3R8WY8"
    else
      ActionController::Base.helpers.asset_path("defaults/" + ["default.png"].compact.join('_'))
    end
  end

end
