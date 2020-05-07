# == Schema Information
#
# Table name: seller_products
#
#  id                      :bigint           not null, primary key
#  unit_cents              :integer          default(0), not null
#  unit_currency           :string           default("USD"), not null
#  order_cents             :integer          default(0), not null
#  order_currency          :string           default("USD"), not null
#  sku                     :string
#  harmonized_system_code  :string
#  country_code_of_origin  :string
#  province_code_of_origin :string
#  packaging               :string
#  packaging_details       :text
#  shelf_life              :string
#  supply_ability          :string
#  weight                  :string
#  status                  :string
#  pause                   :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  product_id              :bigint
#  seller_id               :bigint
#  deleted_at              :datetime
#

class SellerProduct < ApplicationRecord
  after_save :validate_price

  acts_as_paranoid

  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil },
          recipient: Proc.new { |controller, model| controller.user_seller_account ? controller.user_seller_account : nil }

  
  belongs_to :seller, :foreign_key => 'seller_id'
  belongs_to :product, :foreign_key => 'product_id'

  has_many :pricings


  validates_presence_of :product_id


  # Money converter
  # monetize :unit_cents
  # monetize :order_cents


  # Paused
  def is_paused?
    if pause
      "Paused"
    else
      "Active"
    end
  end
  


  private
    
    # Add To Price History
    def validate_price
      # attr_changed? depricated use -> saved_change_to_attr? instead
      # https://blog.toshima.ru/2017/04/06/saved-change-to-attribute.html
      if saved_change_to_unit_price_cents?
        Pricing.create(
          unit_price_cents: self.unit_price_cents,
          unit_price_currency: self.unit_price_currency,
          order_price_cents: self.order_price_cents,
          order_price_currency: self.order_price_currency,
          sale_price_cents: self.order_price_currency,
          sale_price_currency: self.sale_price_currency,
          retail_price_cents: self.retail_price_cents,
          retail_price_currency: self.retail_price_currency,
          sale_start: self.sale_start,
          sale_end: self.sale_end,
          product_id: self.product.id, 
          seller_product_id: self.id,
          seller_id: self.seller.id
        )
      end
    end
    


end
