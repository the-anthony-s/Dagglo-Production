# == Schema Information
#
# Table name: carrier_trucks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#
class CarrierTruck < ApplicationRecord
    has_and_belongs_to_many :carriers
end
