class Carrier < ApplicationRecord
    has_and_belongs_to_many :carrier_trucks
end
