# == Schema Information
#
# Table name: user_locations
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
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  deleted_at :datetime
#
class UserLocation < ApplicationRecord
    acts_as_paranoid

    belongs_to :user, :foreign_key => 'user_id'

    validates_presence_of :name, :address, :country, :city


    
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
