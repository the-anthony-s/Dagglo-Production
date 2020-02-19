class CarrierTruck < ApplicationRecord
    has_and_belongs_to_many :carriers
end