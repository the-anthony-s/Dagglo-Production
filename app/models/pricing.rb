class Pricing < ApplicationRecord

    belongs_to :product
    belongs_to :seller_product

end
